#import "@local/default:0.1.0": setup

#show: setup.with(
  // header: context [#document.title #h(1fr) #counter(page).display()],
  // footer: context [\@author #h(1fr) \<year>],
  guides: true,
)

