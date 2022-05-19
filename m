Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0476A52D234
	for <lists+linux-spi@lfdr.de>; Thu, 19 May 2022 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbiESMO0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 May 2022 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbiESMOV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 May 2022 08:14:21 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5BC6BFE7
        for <linux-spi@vger.kernel.org>; Thu, 19 May 2022 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=F4jCWtSIvtXajyHKb5ke6UfFMUPOAkIRMPSjgeXD7aQ=; b=S9KESA5y+TZ4ZUjdwfY6Wgzlgn
        n5eXOKU6SLTPcWE/aR1WZ+ivi2uNNRY8lvEzx8lkJL/+OqmlkNcixuDyIpwwGcCVGXlzrcIxZIUjM
        ml/vAFZyWbvB8N6z+9mLtlLFoDDiKHSqMpdr1mis2CQAj4K5+10fsqLkDyDlvpMdF2ug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nrf2m-003Tor-I0; Thu, 19 May 2022 14:14:16 +0200
Date:   Thu, 19 May 2022 14:14:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-spi@vger.kernel.org, Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <YoY0mMOfXyf35Y3o@lunn.ch>
References: <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
 <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
 <YoKN/lqrgKJbVBVq@sirena.org.uk>
 <20220517122439.744cf30c@erd992>
 <YoONngxX/jdTjSOH@sirena.org.uk>
 <20220517150906.09a16a47@erd992>
 <YoOmn1k6yEtJofe5@sirena.org.uk>
 <20220517171626.51d50e74@erd992>
 <YoPm0qDaMEogH8n2@sirena.org.uk>
 <20220519101238.516c5f9e@erd992>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519101238.516c5f9e@erd992>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> > Or otherwise make it unobtrusive (eg, with similar techniques to those
> > used by the networking API).
> 
> I just tried this out by re-writing the statistics code using u64_stats_sync
> and per-cpu statistics, which get totaled on sysfs read access as Andrew Lunn
> suggested.
> The results are truly amazing!
> 
> The overhead caused by statistics in my test dropped from 43us to just 1-2us.

When you are potentially dealing with 10 million packets a second, you
cannot spend long on each individual packet incrementing a counter...

> This was tested on a 64-bit machine though, so I don't know how it will affect
> 32-bit systems. Nor do I have an easy means of testing this. Any ideas?

It does make a difference. On a 64 system, you can increment a counter
in a single instruction so you either see the old value, or the new
value. With 32 bit systems, which needs multiple instructions to
increment the counter, so the code takes are you cannot see anything
odd when it needs to overflow from the lower 32bits into the upper 32
bits. So 32bit systems will be a little bit more expensive. However,
not by a lot.

> Also, I have converted all the struct spi_statistics members to u64_stats_t.
> It was easier to test this way. Some of the original types were unsigned long,
> which can have different sizes on 64bit or 32bit systems... is that
> intentional?

You can keep with uint32, if you want to, and keep with the sequence
counter style locking. For networking, 32bit counters can wrap around
pretty fast, so the main counters are 64 bit. But the concept works
O.K. for smaller types.

     Andrew
