Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A245AFBEF
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfIKLxB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 07:53:01 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40883 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKLxB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 07:53:01 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 07:53:00 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C93A9100B05B4;
        Wed, 11 Sep 2019 13:43:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 805AC30C9D7; Wed, 11 Sep 2019 13:43:52 +0200 (CEST)
Date:   Wed, 11 Sep 2019 13:43:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Speed up SPI simplex transfers on Raspberry Pi
Message-ID: <20190911114352.w2htkzfi5v6zl7nq@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
 <20190911104721.GX2036@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911104721.GX2036@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 11, 2019 at 11:47:21AM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2019 at 12:15:30PM +0200, Lukas Wunner wrote:
> > Extend the BCM2835 SPI driver to handle simplex transfers internally,
> > thereby reducing their latency and CPU usage and obviating the need to
> > have the SPI core convert to full-duplex via SPI_CONTROLLER_MUST_TX/RX.
> 
> Whatever you're doing to send these is still not sending the
> patches in order:

I use "git format-patch --thread=shallow", then use a Perl script
to change the Date: header and send out the raw messages with msmtp.

I suspect the incorrect order may be because all messages use the
same Date: header and you're using "sort_aux=date-sent" in Mutt.

I'll change my workflow to use incremental Date: headers.
Sorry for the inconvenience.

You can work around the incorrect order by limiting to messages
from me (type "l", enter "~f lukas@wunner.de"), then ordering
by subject (type "o", then "s").

Thanks,

Lukas
