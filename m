Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4617E6BF
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCISTr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:19:47 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:57703 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgCISTU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:19:20 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B0FD623EDA;
        Mon,  9 Mar 2020 19:19:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583777957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2w6tuRog//c5RJrBIV3CvcBIQfC/GRMRCcWy6DXPrU=;
        b=oxC+SQ6iB8SGjZJd9ssYmn3wa9uWQUaOSyR3hR2y2JuS0Ctc32JnRJ2wT6qf6VGzZ72+0W
        kD1F8qzHygvUO/I7H8fvtBzvBHm7iDkaUzI7Ryg27XXVbhLfc3/8b86EBppedAQLFByM/y
        x3gTfL3I0MuHCT4pfjps9H2RmeT8VEc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 19:19:17 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Subject: Re: [PATCH 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR
 CMD and TXDATA
In-Reply-To: <CA+h21hp4vC1c00rCgZo_hwQz3cE4dLBHjcgTHvf-+fS9a9VfxQ@mail.gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-3-olteanv@gmail.com>
 <d8e39e402328b962cdbc25316a27eac8@walle.cc>
 <CA+h21hp4vC1c00rCgZo_hwQz3cE4dLBHjcgTHvf-+fS9a9VfxQ@mail.gmail.com>
Message-ID: <a709dc91aac9124ed37ac1e7fcb7e105@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: B0FD623EDA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.538];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-09 19:07, schrieb Vladimir Oltean:
> Hi Michael,
> 
> On Mon, 9 Mar 2020 at 19:59, Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
>> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> >
>> > In XSPI mode, the 32-bit PUSHR register can be written to separately:
>> > the higher 16 bits are for commands and the lower 16 bits are for data.
>> >
>> > This has nicely been hacked around, by defining a second regmap with a
>> > width of 16 bits, and effectively splitting a 32-bit register into 2
>> > 16-bit ones, from the perspective of this regmap_pushr.
>> >
>> > The problem is the assumption about the controller's endianness. If the
>> > controller is little endian (such as anything post-LS1046A), then the
>> > first 2 bytes, in the order imposed by memory layout, will actually
>> > hold
>> > the TXDATA, and the last 2 bytes will hold the CMD.
>> >
>> > So take the controller's endianness into account when performing split
>> > writes to PUSHR. The obvious and simple solution would have been to
>> > call
>> > regmap_get_val_endian(), but that is an internal regmap function and we
>> > don't want to change regmap just for this. Therefore, we define the
>> > offsets per-instantiation, in the devtype_data structure. This means
>> > that we have to know from the driver which controllers are big- and
>> > which are little-endian (which is fine, we do, but it makes the device
>> > tree binding itself a little redundant except for regmap_config).
>> >
>> > This patch does not apply cleanly to stable trees, and a punctual fix
>> > to
>> > the commit cannot be provided given this constraint of lack of access
>> > to
>> > regmap_get_val_endian(). The per-SoC devtype_data structures (and
>> > therefore the premises to fix this bug) have been introduced only a few
>> > commits ago, in commit d35054010b57 ("spi: spi-fsl-dspi: Use specific
>> > compatible strings for all SoC instantiations")
>> >
>> > Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode
>> > registers")
>> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> > ---
>> >  drivers/spi/spi-fsl-dspi.c | 28 ++++++++++++++++++++++------
>> >  1 file changed, 22 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> > index 0ce26c1cbf62..a8e56abe20ac 100644
>> > --- a/drivers/spi/spi-fsl-dspi.c
>> > +++ b/drivers/spi/spi-fsl-dspi.c
>> > @@ -103,10 +103,6 @@
>> >  #define SPI_FRAME_BITS(bits)         SPI_CTAR_FMSZ((bits) - 1)
>> >  #define SPI_FRAME_EBITS(bits)                SPI_CTARE_FMSZE(((bits) - 1) >> 4)
>> >
>> > -/* Register offsets for regmap_pushr */
>> > -#define PUSHR_CMD                    0x0
>> > -#define PUSHR_TX                     0x2
>> > -
>> >  #define DMA_COMPLETION_TIMEOUT               msecs_to_jiffies(3000)
>> >
>> >  struct chip_data {
>> > @@ -124,6 +120,12 @@ struct fsl_dspi_devtype_data {
>> >       u8                      max_clock_factor;
>> >       int                     fifo_size;
>> >       int                     dma_bufsize;
>> > +     /*
>> > +      * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
>> > +      * individually (in XSPI mode)
>> > +      */
>> > +     int                     pushr_cmd;
>> > +     int                     pushr_tx;
>> >  };
>> 
>> Shouldn't this just read the "little-endian" property of the
>> device tree node?
> 
> This is exactly what the driver did prior to this commit from 2014:
> https://patchwork.kernel.org/patch/4732711/
> Since then, "little-endian" and "big-endian" became generic regmap 
> properties.
> 
>> Like it worked before with regmap, which takes
>> the little-endian/big-endian property into account.
>> 
> 
> So XSPI mode allows you, among other things, to send 32 bits words at a 
> time.
> In my opinion this was tested only the big-endian DSPI controllers
> (LS1021A, LS1043A etc).
> On the little-endian controllers (LS2, LX2, LS1028A) I suspect this
> was actually never tested.
> The reason why we see it now is because we're "accelerating" even
> 8-bit words to 32-bit.
> So it is incorrect to say "like it worked before": it never worked 
> before.

I just meant how the endianess is figured out ;) Like by using the
endianess property in the device tree. Not by also taking the compatible
string into account.


>> If I understand this correctly, this solution would mix the methods
>> how the IP endianess is determined. Eg. regmap_xx uses the
>> little-endian property and this driver then also uses the compatible
>> string to also distinguish between the endianess.
>> 
> 
> Yup. Otherwise we effectively have to duplicate the logic from the
> internal regmap_get_val_endian function. I found no other way to
> figure out what endianness the regmap_config has. Suggestions welcome.

If there is no way in determining that, you could just use the
of_property_read_bool(). there is also of_device_is_big_endian()
although I don't know if this is consistent with how the regmap uses it.
Eg. is it big-endian or little-endian if there is no property at all?

I mean something like:

if (little_endian)
     regmap_write(regmap, PUSHR_CMD_LE, cmd)
else
     regmap_write(regmap, PUSHR_CMD_BE, cmd)

Eg. if one would add another SoC to the DSPI driver, you would also need
to specify the cmd/tx offset. But actually its already known because it
just depend on the endianess which is already specified in the device 
tree.

-michael
