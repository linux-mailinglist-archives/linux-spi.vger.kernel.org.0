Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA35452D757
	for <lists+linux-spi@lfdr.de>; Thu, 19 May 2022 17:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbiESPWJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 May 2022 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbiESPWJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 May 2022 11:22:09 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED275EDEF
        for <linux-spi@vger.kernel.org>; Thu, 19 May 2022 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=P4fzTYa22woHFq/f4jvQVWsujdbz9aCf3xBckQk17fY=; b=vkaHffHMDPEUUIBMsgC7jXDeUB
        ivLWeUHx6kAy3NQrZMNHL7bN4pjARtn7kdodlYLL+KIT4ivwvJxacr9sqUnus1j3L3S109WCELQKL
        fgtZ8ar7P6RSVSzwVY/mtYPHmQrpwxrn7aZigMj8utLDnScYVhMm6WrM8rZQmhdMI/24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nrhyR-003VXw-Ee; Thu, 19 May 2022 17:21:59 +0200
Date:   Thu, 19 May 2022 17:21:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-spi@vger.kernel.org, Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <YoZgl5xMmt+SCS2L@lunn.ch>
References: <YoKN/lqrgKJbVBVq@sirena.org.uk>
 <20220517122439.744cf30c@erd992>
 <YoONngxX/jdTjSOH@sirena.org.uk>
 <20220517150906.09a16a47@erd992>
 <YoOmn1k6yEtJofe5@sirena.org.uk>
 <20220517171626.51d50e74@erd992>
 <YoPm0qDaMEogH8n2@sirena.org.uk>
 <20220519101238.516c5f9e@erd992>
 <YoY0mMOfXyf35Y3o@lunn.ch>
 <20220519163327.606295d2@erd992>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519163327.606295d2@erd992>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Since I am already moving the stats to per-cpu structs, wouldn't atomic_inc()
> be sufficient and even faster for uint32 stats on 32bit systems?

atomic is expensive, because it needs to synchronise across all
CPUs. And that synchoniszation across all CPUs is pointless when you
are doing per-cpu counters.

> I still would like to hear Mark's idea on the exact types. All bytes stats
> were ULL and transfer counter values were UL. Possibly the reason behind this
> was to make the transfer counters as efficient to increment as possible for
> the given platform, as should be the case for "unsigned long".

That efficiency argument is however broken by the use of a spinlock,
which is much more expensive than the actually increment. Except for a
UP machine when it becomes a NOP. But UP machines are becoming less
and less common.

      Andrew
