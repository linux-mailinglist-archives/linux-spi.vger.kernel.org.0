Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F4015A9B8
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2020 14:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLNJD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Feb 2020 08:09:03 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42777 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLNJC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Feb 2020 08:09:02 -0500
Received: by mail-il1-f193.google.com with SMTP id x2so1651020ila.9;
        Wed, 12 Feb 2020 05:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwgzXOkICXCQfXrNHWXrCftoLfH9Scd8moCWKuZ8A7c=;
        b=uwP0fhVrX+cKaPrA9gZuzCsKp0yddAX94jEyXD+oxpoLTWMMqVteKVFhQIfbax7itw
         LTgnQhEBPH1h/TZFReuXAGeaSeQs3IeZGCBz9HlL5RRSoErDbx/VHPZz1N9s6W4tavzm
         tRI7PsSWpP61qEZOKSCUIjyPXdiR1pfk5omo4L+DP4BGIMk76I6FO9jnbIsamlo43As1
         vE6g7V0GDiRYWnLArr4NKRwoaRkGq92lsMI7sj8ISNP5sQit0d+XhUhDDSwyBqtr8A82
         nPjSpLQlG48uHNHO8yaTHauwI0bT2iFl7Ih0ObcSXH56oeHLWsj+0PBQvlsD3p8ywO9E
         l4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwgzXOkICXCQfXrNHWXrCftoLfH9Scd8moCWKuZ8A7c=;
        b=gMSxSAJlcotjlHnEVv4knvm6hBWseH2/ENnizaX0ZtI8nl/eWsHUcAz/OgU9o6igbs
         BNnsb75X6D0XVW/8ZgCSuNvj0ioGf9tZ9Mek7jVaUsJlUIhT76Fb81YYK8YcRnia7xHl
         ZS73qHt4U9lJDOZZM5Cvk7pa64DWSkvGmumRaPlyk5UpDtrWZeJE7CC7Q2d4dgtU6EwM
         XETdltm9CTVNNV6i7WZUIw4d2c+qKNeG0QVCTMG6W2xO7oC9qPm338XfHkpI3Zhr5D68
         9l0XleyQWrwnzGs8I0GA/GXOfvF3LfEo0IcWLGS9gHp0Tar62FoQHwxnW5Wg0XOA8fZ9
         H2+w==
X-Gm-Message-State: APjAAAUr15ZKzOWB+AiyYZpD5asE3nME4W2qHbhruuBef3EBBDkRngd5
        IshdkEympbD/3S1v1VKaf+E+fK+y1ZGgwkf6gnM=
X-Google-Smtp-Source: APXvYqzwGZCfLCucPj5npcA6pFh/Daw5mAO0fUTiKusa4iACLpoLiJs+a3YdEul7VJ0Sa7qkhI7BVMm1OAQ3UfESN3g=
X-Received: by 2002:a92:350d:: with SMTP id c13mr11345711ila.205.1581512940477;
 Wed, 12 Feb 2020 05:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20200202125950.1825013-1-aford173@gmail.com> <20200202125950.1825013-2-aford173@gmail.com>
 <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
 <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com> <20200212120753.GF4028@sirena.org.uk>
In-Reply-To: <20200212120753.GF4028@sirena.org.uk>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 12 Feb 2020 07:08:49 -0600
Message-ID: <CAHCN7x+5bACfYVX49Lib+fmNq-dEOkcyi0gXt7rtYxrGaYbH1Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
To:     Mark Brown <broonie@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Feb 12, 2020 at 6:07 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Feb 03, 2020 at 04:53:34AM -0600, Adam Ford wrote:
>
> > My motivation is to get the flexspi on the i.MX8MM to work, and I did
> > a list of the patches applied on the NXP branch to see what was
> > applied on top of their 4.19 kernel and this patch series generated
> > from that list.  Most of the NXP commits are one-line commits, and I
> > don't know the motivation for what's happening.  NXP did it, and I
> > know it works on the Flexspi driver.
>
> Adding new compatibles and so on seems fine but the patches making
> random changes without explanation like the one for octal mode I just
> replied to are more worrying, do they work with older versions of the IP
> or in all use cases for example?  I'd suggest cutting the initial patch
> series down to the bare minimum needed to get things working and then
> building on top of that if that's not already been done.

The original author was copied on the initial commit.  I literally
generated the patch from NXP's branch,  added my notes, and pushed
them to the mailing lists after testing them on the  the Linux master
branch.   I am a bit disappointed that NXP's author hasn't responded
to any of the comments or feedback.  NXP knows their hardware and
better understands the details as to what is happening and why.  In
any case,  I'll try to scale the patch series back to just enough to
get it working on the i.MX8M Mini.  I'll expand a bit on the commit
message based on what I've learned about the various in-implemented
quirks and send a V2 series.

adam
