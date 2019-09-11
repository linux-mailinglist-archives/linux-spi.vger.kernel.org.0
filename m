Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9AAFBF1
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 13:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfIKLxa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 07:53:30 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:49853 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKLxa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 07:53:30 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 76B0E3000CA22;
        Wed, 11 Sep 2019 13:53:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4F3F430C9E9; Wed, 11 Sep 2019 13:53:28 +0200 (CEST)
Date:   Wed, 11 Sep 2019 13:53:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/10] spi: bcm2835: Work around DONE bit erratum
Message-ID: <20190911115328.zcfphci2abukfgvs@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
 <7ceb98f154cdcf72c577615fa312df41adea5f47.1568187525.git.lukas@wunner.de>
 <20190911112522.GD2036@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190911112522.GD2036@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 11, 2019 at 12:25:22PM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2019 at 12:15:30PM +0200, Lukas Wunner wrote:
> > Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
> > limitation") amended the BCM2835 SPI driver with support for DMA
> > transfers whose buffers are not aligned to 4 bytes and require more than
> > one sglist entry.
> 
> You said in the cover letter that this was at the start of the
> series but it's actually patch 4

All preceding patches do not touch spi-bcm2835.c,
that's what I meant with "front of the series".


> and in any case it was already applied so
> I'm not clear why you're resending it.

I based the series on your for-5.4 branch and didn't notice that you had
already applied this one to for-5.3.  This wasn't really meant as a fix
and it's not necessary for it to to be applied to for-5.3, though there's
no harm either as long as it lands in Linus' tree before the other
patches in this series.


> If there's any difference
> from the previous version please send an incremental fix for it
> instead.

There is no difference aside from a Tested-by tag for Noralf Trønnes
which is missing from the commit on your for-5.3 branch.

Thanks,

Lukas
