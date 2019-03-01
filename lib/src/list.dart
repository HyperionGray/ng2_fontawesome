import 'package:angular/core.dart';

import 'icon.dart';

/// A component that renders an unordered list with Font Awesome icons as
/// bullets.
@Component(
    selector: 'fa-ul',
    styleUrls: const ['css/all.min.css'],
    template: '''<ul style="position: relative" class="fa-ul">
        <ng-content></ng-content></ul>'''
)
class FaList implements AfterContentInit {
    /// Default bullet to use for list items.
    @Input()
    String bullet;

    /// The style of the default bullet: solid, regular, or brand. (Default:
    /// solid)
    @Input()
    String style = 'solid';

    /// Icon list items nested inside this element.
    @ContentChildren(FaListItem)
    List<FaListItem> childIcons;

    /// Implementation of AfterContentInit.
    void ngAfterContentInit() {
        if (this.bullet != null) {
            _copyBulletToChildren();
        }
    }

    /// Copy the bullet icon into any children that don't have one.
    void _copyBulletToChildren() {
        print('copy bullet');
        for (var childIcon in childIcons) {
            if (childIcon.bullet == null) {
                childIcon.bullet = this.bullet;
                childIcon.style = this.style;
            }
        }
    }
}

/// A component that renders a list item with a Font Awesome icon as the
/// bullet.
@Component(
    selector: 'fa-li',
    styleUrls: const ['css/all.min.css'],
    template: '''<li><span class="fa-li"><fa [style]="style" [name]="bullet">
        </fa></span><ng-content></ng-content></li>''',
    directives: const [FaIcon]
)
class FaListItem {
    /// Name of icon to use for this list item's bullet.
    @Input()
    String bullet;

    /// The style of the bullet: solid, regular, or brand. (Default: solid)
    @Input()
    String style = 'solid';
}
