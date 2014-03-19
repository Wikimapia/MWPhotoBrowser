Pod::Spec.new do |s|
    s.name = 'MWPhotoBrowser'
    s.version = '1.4.0'
    s.license = 'MIT'
    s.summary = 'A simple iOS photo browser. Supports edit options per photo.'
    s.description = 'MWPhotoBrowser can display one or more images by ' \
                    'providing either UIImage objects, or URLs to files, ' \
                    'web images or library assets. The photo browser ' \
                    'handles the downloading and caching of photos from ' \
                    'the web seamlessly. Photos can be zoomed and panned, ' \
                    'and optional (customisable) captions can be  ' \
                    'displayed. The browser can also be used to allow the ' \
                    'user to select one or more photos using either the ' \
                    'grid or main image view.'
    s.screenshots = ['https://raw.github.com/Wikimapia/MWPhotoBrowser/' \
                     'master/Preview/MWPhotoBrowser1.png',
                     'https://raw.github.com/Wikimapia/MWPhotoBrowser/' \
                     'master/Preview/MWPhotoBrowser2.png',
                     'https://raw.github.com/Wikimapia/MWPhotoBrowser/' \
                     'master/Preview/MWPhotoBrowser5.png']
    s.homepage = 'https://github.com/Wikimapia/MWPhotoBrowser'
    s.author = { 'Michael Waterfall' => 'michaelwaterfall@gmail.com' }
    s.source = {
        :git => 'https://github.com/Wikimapia/MWPhotoBrowser.git',
        :tag => '1.4.0'
    }
    s.platform = :ios, '6.0'
    s.source_files = 'MWPhotoBrowser/Classes/*.{h,m}'
    s.resources = 'MWPhotoBrowser/MWPhotoBrowser.bundle'
    s.requires_arc = true
    s.frameworks = 'MessageUI', 'ImageIO', 'QuartzCore', 'AssetsLibrary', 'MapKit'
    s.dependency 'SDWebImage', '~> 3.5.4'
    s.dependency 'MBProgressHUD', '~> 0.8'
end
