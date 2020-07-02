Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB6A212094
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgGBKFm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:05:42 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:17783 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGBKFm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684342; x=1625220342;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=RBWjTChbCjPvUe1E+aZiJAR02zh0ahhxuDu7LpVx5kc=;
  b=PknMzdJwCv7TuAhf28UOgMZJbawmCE9ZdKQmfdWHnLKTJlHUDPfxSal1
   ZD8igghzOqLm6ROAAvXRPQRVjKfbxgzlRFODmxwsU6tGy+yQZsODXUvcj
   4lr61xxXjtuREXl6KeX9oPBUBvAEbk0qDwnsumR/fzyHEoslOwJgAe890
   e7uJQXB+zg/nC2lTvTtVWTvza4fyT9XsIlZABcX9YBF+WEobj3HCZ+F4W
   Ck7KgqVFenekofGQ8uYhfd/XFiWrESc8dFWorf69odg8QZ5VnqcQBUoDm
   gb7hYvhp8xnwentBylyqqs6hvYrSFSFMM5a8aVvXNW35zXEX3ovEWCGDh
   Q==;
IronPort-SDR: VLUqmLLE5o47q9NlTPvtAiIaITBHkG8uGV4ylYG0DsMy6+P2erE9W/WtNilmUrJNwFm6GKCF53
 wP847YZnw82CvZmjPjH+0FK9hHwyefm7ayfXUwHRQ+LWwdZE7XhLgc1J4ivuk00UfHv83Z0j5j
 ox7fYWxHTVuhyQ6vuqwGN/Y+gG+kOYn5Zc5tM4ur/HWFTe2dCaa+5BGWqyRoUIYzoThudV4JW8
 yQi32t+6Ag/mBPrTGipK4A8Y8pN9K4QoCYU6QYtALLZ3GmQnCnx+Qn0cjNKp7L+EZXGI2nfjmp
 QgA=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="82368183"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:05:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:05:17 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 2 Jul 2020 03:05:34 -0700
References: <20200619113121.9984-1-lars.povlsen@microchip.com> <20200619113121.9984-4-lars.povlsen@microchip.com> <20200619121107.GE5396@sirena.org.uk> <87imfjxtrq.fsf@soft-dev15.microsemi.net> <20200622121706.GF4560@sirena.org.uk> <878sgddh2l.fsf@soft-dev15.microsemi.net> <20200623140815.GF5582@sirena.org.uk>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 3/6] spi: dw: Add Microchip Sparx5 support
In-Reply-To: <20200623140815.GF5582@sirena.org.uk>
Date:   Thu, 2 Jul 2020 12:05:32 +0200
Message-ID: <874kqqkz9v.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Mark Brown writes:

> On Tue, Jun 23, 2020 at 03:53:22PM +0200, Lars Povlsen wrote:
> > Mark Brown writes:
> 
> > >If there's a mux that needs to be handled specially that mux should be
> > >described in DT on the relevant boards, there shouldn't just be
> > >something hard coded in the controller driver.
> 
> > I looked at the spi-mux driver, but that is more for muxing the CS's, as
> > I understand - not the actual bus segment. I could use it, but it would
> 
> It doesn't matter that much exactly what signals get switched I think,
> we can't really tell by the time we get back to the controller.
> 
> > require encoding the bus segment into the CS (double the normal
> > range). Also, selecting the bus interface is tightly coupled to the
> > controller - its not an externally constructed board mux.
> 
> It sounds like this controller should be describing a mux all the time -
> if there's completely separate output buses that you can switch between
> then we'll need to know about that if someone wires up a GPIO chip
> select.

Mark,

I had to tinker a bit with this to get my head around it.

I added the mux driver, and made the cs/bus configuration reside here -
all well and done.

For our reference config we have something like:

  mux: mux-controller {
          compatible = "microchip,sparx5-spi-mux";
          #mux-control-cells = <0>;
          mux@0 {
                  reg = <0>;
                  microchip,bus-interface = <0>;
          };
          mux@e {
                  reg = <14>;
                  microchip,bus-interface = <1>;
          };
  };

Then I tried to use the existing spi-mux as you suggested. But I
realized as its really designed for CS muxing I had to instantiate each
SPI device in its own spi-mux instance, repeating the CS (as we don't
want that to change). The result was kinda bulky.

An example would be:

  spi0: spi@600104000 {
          compatible = "microchip,sparx5-spi";
          spi@0 {
                  compatible = "spi-mux";
                  mux-controls = <&mux>;
                  reg = <0>;
                  spi-flash@0 {
                          compatible = "jedec,spi-nor";
                          reg = <0>;
                  };
          };
          spi@e {
                  compatible = "spi-mux";
                  mux-controls = <&mux>;
                  reg = <14>;
                  spi-flash@e {
                          compatible = "spi-nand";
                          reg = <14>;
                  };
          };
  };

I then looked a bit at other users of the mux framework,
drivers/mtd/hyperbus/hbmc-am654.c specifically.

I then added direct use of a mux, by the well-established "mux-controls"
DT property. The result was much cleaner, IMHO, and allows the spi and
mux to be connected directly in the base sparx5 DT. Code impact was
really small.

Both examples use the same mux configuration, and as the "mux-controls"
is established by default in the base spi0 node, this (directly) yields:

&spi0 {
	spi-flash@0 {
		compatible = "jedec,spi-nor";
		reg = <0>;
	};
	spi-flash@e {
		compatible = "spi-nand";
		reg = <14>;
	};
};

I will be sending the new revision of the patches shortly. I look
forward to your comments.

I also CC'ed Peter Rosin as the MUX subsystem maintainer. Peter, sorry
for sticking you halfway into a conversation, but I thought you might
want to be informed. You are also on the recipient list of the v3
patches, so now you know why...

Sincerely,

-- 
Lars Povlsen,
Microchip
