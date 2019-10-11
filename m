Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6980D38BA
	for <lists+linux-spi@lfdr.de>; Fri, 11 Oct 2019 07:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfJKFj2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Oct 2019 01:39:28 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:5809 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfJKFj1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Oct 2019 01:39:27 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Oct 2019 01:39:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570772367; x=1602308367;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=yJ5YGvrPcyRX5zC7jVyQFboOGLnco0MT2oGaJMlgWhA=;
  b=baFozJllJ5HYEyjG0sfEW5cXWRCApGlYd52OL3VtqowUY0UwuSmtSTuQ
   4gToD6D/AUsN9MlDePEp+HEtKHO0KsoJu9TLYCIpL5SzU4lVRwNLVQIg9
   GfrTzOOeNOj28KkXXb5JZEueHDul698F1nziq5ymC/TkQQKNQQD/tzbNN
   UzP7E7ACOgH7l7GHnsYKxwzqDkDAjmbWX71+oSJbSOZy9ZG24riV2AUit
   TomJMcCDsFAtvttS6SC3cGkgwlgBLaUfS9DGpUaA/GeXr691cmm1B7Q/0
   BVIKm16+spFwU0yUHbjIarQJfGyfNC2EV7hO25zIB4W0uosyvu5OmBbOZ
   A==;
IronPort-SDR: TqNLhww2vtAs7VY6FKO1UJGWTX9eQSCJMRrxH89pho7fCtSOMp0fT3vOlCFhMW0a6CXEynyRKG
 3ZvDK1yOKXHqGHsyguTFRicGk4tC1GSRLcs+TBZaTe7tdVopJjWeC/UJLNFe1VWSje7e7uzYyc
 0mZXkle5cAVT0q98nOfHFJCoKakIwN5keiTGBevhUZQXErXLzCY7foQC9vB1SjzlkVEI4FJZXB
 HkFxBKGtSgHGX4QysOqxCOFCEsjQ0Oyzadt+UcwKnhc0q744wbn6LyiOB8tWhfnJraaBvch5XM
 shw=
IronPort-PHdr: =?us-ascii?q?9a23=3ARvnlXR1/LYHtLOuZsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8Zse0RLPad9pjvdHbS+e9qxAeQG9mCsLQa16GH7ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7J/IRq5oQjVtsQdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cWG?=
 =?us-ascii?q?FPXNteVzZZD4yzYYsADeoPM+hboYfguVUBsQCzBRWwCO711jNEmmP60K883u?=
 =?us-ascii?q?88EQ/GxgsgH9cWvXvWrdX0NacSUf2yzKLVzjrDb+lZ2Tbg44XPchEgoPGMUq?=
 =?us-ascii?q?hxccbN1UUiGRjIjkiMpoz/JT+ayPkCs3WC4udmSOmhiHYnphlvrjSzwsogkI?=
 =?us-ascii?q?rEi4IPxlza6Sl0w5w5KcC8RUN/Z9OvDYFeuDuAN4RsR8MvW2RouCEnxbIYoZ?=
 =?us-ascii?q?O7Zy0KyIg/xx7YdvyHb5CE4hL9W+aVJjd1nHdld6i+hxa26ESgzu/8WtSt3F?=
 =?us-ascii?q?ZEsyZIlt3BumoC1xzU7ciHRf998Vm71TmT0ADT7/lIIUEylaXFN54s2qA8mo?=
 =?us-ascii?q?YXvEjZHSL7mF/6gLGKekgn4OSk9uDqb7H+qp+ZLYB0iwX+Mqo0msy4BOQ1Kg?=
 =?us-ascii?q?gPXmmb+eum1b3v4VH1TbtRg/0rjqbZqorWKtoGqa6kGwNVyJos6w6jDze619?=
 =?us-ascii?q?QVhX0HLFNDeBKagInlIkrOIOj5DfqknVSsnylkx+rcMr3iHJrNNH7Dn6nlfb?=
 =?us-ascii?q?pn7E5c0gUznphj4Md5ELAKaN7uX0bjucCQWhIjMgfyz/viAcdwyqsRXGuOBu?=
 =?us-ascii?q?mSN6aE4nGS4ed6EuieZJIS8AT9Ivlts+/8jXY4wQdGVbSix90aZG3uTacuGF?=
 =?us-ascii?q?mQfXe52oRJKmwNpAdrCbWy0FA=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HTAwCbE6Bdh8fQVdFlHgELHIYMKoQ?=
 =?us-ascii?q?jjl2CD4lpj1WBZwEIAQEBDi8BAYRAAoJdIzgTAgMJAQEFAQEBAQEFBAEBAhA?=
 =?us-ascii?q?BAQEIDQkIKYVAgjopAYM9AQEBAxIRVhALCw0CAiYCAiEBEgEFARwGEyKDAIJ?=
 =?us-ascii?q?HAy4FpH2BAzyLJoEyiBINTAEJDYFIEnoojA6CF4ERgmQuPoIagXcBEgGDLYJ?=
 =?us-ascii?q?eBIE5AQEBizeJeJYXQAEGAoIQFIxUhD2ECBuZQJhdjx8PI4FGgQpxMxolfwZ?=
 =?us-ascii?q?ngU5QEBSBaY5MJDCOMYJFAQE?=
X-IPAS-Result: =?us-ascii?q?A2HTAwCbE6Bdh8fQVdFlHgELHIYMKoQjjl2CD4lpj1WBZ?=
 =?us-ascii?q?wEIAQEBDi8BAYRAAoJdIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAg?=
 =?us-ascii?q?jopAYM9AQEBAxIRVhALCw0CAiYCAiEBEgEFARwGEyKDAIJHAy4FpH2BAzyLJ?=
 =?us-ascii?q?oEyiBINTAEJDYFIEnoojA6CF4ERgmQuPoIagXcBEgGDLYJeBIE5AQEBizeJe?=
 =?us-ascii?q?JYXQAEGAoIQFIxUhD2ECBuZQJhdjx8PI4FGgQpxMxolfwZngU5QEBSBaY5MJ?=
 =?us-ascii?q?DCOMYJFAQE?=
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="82087557"
Received: from mail-lj1-f199.google.com ([209.85.208.199])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2019 22:31:58 -0700
Received: by mail-lj1-f199.google.com with SMTP id i18so1494016ljg.14
        for <linux-spi@vger.kernel.org>; Thu, 10 Oct 2019 22:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tv2M3bVEOwTFf6PpVjYYQE3JCPAHcwi1kAhVSyKoUk8=;
        b=jOsTAV4XPjXxxUorAcp2FLbtV6+ELpmMCT0BRw+T+0UnHGc80+AWaufFS8X72SOnZQ
         ffiJ2HUlqd43ZatbAI/+WngoQx9llWAdv/ah9oNA51Dqx5MW3+lqeWai/tDVwqBoSePr
         upSEKXgaO0OaOPhcRfPzHchdbLMmSMxcoW2Tw1LPG3TpUOPkSXOi24RdNAM9Edkg9u3b
         boIjY6rRSi2ziRBHbBF/1Bxfk3aS4zS+BlblU3ToBc/wd/RC9761phVaFEI436IAHuRt
         ztvhk63WXK+m0Gh+3PWmg9y1CpZRjXbvTUs1KZEF5fB9VWRAuY/lMFYlJorwkTZF2+WJ
         pVww==
X-Gm-Message-State: APjAAAWyZ3qCOqTyd7Eu+D63w42eh/KWPsmF+CM909bpJKvzdvlNW6Io
        Yg3ijkBDSOERdW2IVMWKkK9mrWvNT9mEjLjBi+xcFUJ8iNscbtkWgHjF4qyhtOFFwwfDuRN+8do
        zLYB0hrynd2PO6o33KqFI5bUMmNDRwSVqr1KT2A==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr8212623ljj.181.1570771916657;
        Thu, 10 Oct 2019 22:31:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHP44PVHjs0kFISU2ps2cAigGwbjhhimKB33YZ1L/BeZfqzW5I3WsJw/QcMLDk/A8RKn0EguzvxM0b+UUoSQQ=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr8212613ljj.181.1570771916412;
 Thu, 10 Oct 2019 22:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
 <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
In-Reply-To: <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 10 Oct 2019 22:31:28 -0700
Message-ID: <CABvMjLTrGprdgFTP-+2XC_p+vE+tVWeYvyuLGkKj1dY7KR+JDg@mail.gmail.com>
Subject: Re: Potential NULL pointer deference in spi
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Eric:

My apologies for bothering, we got those report via static analysis
and haven't got a good method to verify the path to trigger them.
Therefore I sent those email to you maintainers first since you
know much better about the details. Sorry again for your time and
I take your suggestions.

On Wed, Oct 9, 2019 at 10:48 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/9/19 10:37 PM, Yizhuo Zhai wrote:
> > Hi All:
> >
> > drivers/spi/spi.c:
> >
> > The function to_spi_device() could return NULL, but some callers
> > in this file does not check the return value while directly dereference
> > it, which seems potentially unsafe.
> >
> > Such callers include spidev_release(),  spi_dev_check(),
> > driver_override_store(), etc.
> >
> >
>
>
> Many of your reports are completely bogus.
>
> I suggest you spend more time before sending such emails to very large audience
> and risk being ignored at some point.
>
> Thanks.



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
