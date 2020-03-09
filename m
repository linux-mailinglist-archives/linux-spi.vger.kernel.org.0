Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B4617E7A2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCIS6H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:58:07 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33633 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgCIS6H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:58:07 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 17AEC23EDA;
        Mon,  9 Mar 2020 19:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583780284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hS0zEEOUXqG6QOkQ9z4+cDNB6shmJNlq0wBwtzctXZ4=;
        b=tIdaUe6zUv3UV2sk/HK81rHp1tEgrSQ5b4Fy36wBTqUlU/bW4axlVYaHhsFA4lewm7WCr2
        sT6Ahj6xzboRdmpfwrXMfeNg7iqBgprfgoPeIMjkPe7BGZbAUscl9rYSO4XmrnwxY5zRk0
        NvXC9CvtcqrLXZKBK6JlE2iZtoMiSgk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 19:58:04 +0100
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
Subject: Re: [PATCH 6/6] arm64: dts: ls1028a-rdb: Add a spidev node for the
 mikroBUS
In-Reply-To: <CA+h21hqOhM9+k9cKXoA8coYpxNFWpgD+FjETeB6uWLbsfrx0uw@mail.gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-7-olteanv@gmail.com>
 <f213388d924b63d0fe265a2d731647be@walle.cc>
 <CA+h21hqOhM9+k9cKXoA8coYpxNFWpgD+FjETeB6uWLbsfrx0uw@mail.gmail.com>
Message-ID: <0700435a8355c9a53049d571d41da222@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 17AEC23EDA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.0:email];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.366];
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

Am 2020-03-09 19:50, schrieb Vladimir Oltean:
> On Mon, 9 Mar 2020 at 20:35, Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
>> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> >
>> > For debugging, it is useful to have access to the DSPI controller
>> > signals. On the reference design board, these are exported to either
>> > the
>> > mikroBUS1 or mikroBUS2 connector (according to the CPLD register
>> > BRDCFG3[SPI3]).
>> >
>> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> > ---
>> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> > index bb7ba3bcbe56..43f403b30dae 100644
>> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> > @@ -83,6 +83,20 @@
>> >       };
>> >  };
>> >
>> > +&dspi2 {
>> > +     bus-num = <2>;
>> > +     status = "okay";
>> > +
>> > +     /* mikroBUS1 */
>> > +     spidev@0 {
>> > +             compatible = "spidev";
>> 
>> As far as I know this throws a warning at boot that you
>> shouldn't use the compatible = "spidev", doesn't it?
>> 
>> /*
>>   * spidev should never be referenced in DT without a specific
>>   * compatible string, it is a Linux implementation thing
>>   * rather than a description of the hardware.
>>   */
>> 
> 
> If this is supposed to mean that the "spidev" string is less
> adequate/expressive than "rohm,dh2228fv", then ok, I'll use that.

TBH I don't care, its your board ;) But I suppose that there is no
Rohm DH2228FV on the (pluggable) mikroBUS board. I just noticed
that compatible string. Don't shoot the messenger ;)

-michael

> 
>> -michael
>> 
>> > +             reg = <0>;
>> > +             spi-max-frequency = <20000000>;
>> > +             fsl,spi-cs-sck-delay = <100>;
>> > +             fsl,spi-sck-cs-delay = <100>;
>> > +     };
>> > +};
>> > +
>> >  &esdhc {
>> >       sd-uhs-sdr104;
>> >       sd-uhs-sdr50;
