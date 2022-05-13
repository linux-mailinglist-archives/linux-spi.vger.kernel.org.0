Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C1526190
	for <lists+linux-spi@lfdr.de>; Fri, 13 May 2022 14:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380139AbiEMMKj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 May 2022 08:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380126AbiEMMKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 May 2022 08:10:39 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837D2944A3
        for <linux-spi@vger.kernel.org>; Fri, 13 May 2022 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aydeXpqXD1I2tjJafvP5KnYO/pOOIvIgr8D83iFAU7Y=; b=usXWa1rJWlINFOloaQVOrw6Va6
        W1saMWlTwz4r9T3CVx64f/YS+stpIhnILi21kSYJh1vZ13wfeQnZrOMng0kPO3MaITe+Kffca4WAj
        eC0+V880g6AR6FvxsZ/7NzjeTBzvo9pxLYxVbozB22cgLglg7NCY3ehY460pzopIHjwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1npU7s-002aVR-Iu; Fri, 13 May 2022 14:10:32 +0200
Date:   Fri, 13 May 2022 14:10:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <Yn5KuOF7aH6xEAH0@lunn.ch>
References: <20220512163445.6dcca126@erd992>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512163445.6dcca126@erd992>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> 6.1. Accounting spinlocks:
> 
> Spinlocks are supposed to be fast, especially for the case that they are not
> contested, but in such critical paths their impact shouldn't be neglected.
> 
> SPI_STATISTICS_ADD_TO_FIELD: This macro defined in spi.h has a spinlock, and
> it is used 4 times directly in __spi_sync(). It is also used in
> spi_transfer_one_message() which is called from there. Removing the spinlocks
> (thus introducing races) makes the code measurably faster (several us).
> 
> spi_statistics_add_transfer_stats(): Called twice from
> spi_transfer_one_message(), and also contains a spinlock. Removing these again
> has a measurable impact of several us.

Maybe something from the network stack can be learnt here:

https://www.kernel.org/doc/html/latest/locking/seqlock.html

https://elixir.bootlin.com/linux/v5.18-rc6/source/include/linux/u64_stats_sync.h

	Andrew
