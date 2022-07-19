Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B989A57947D
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 09:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiGSHrG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 03:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiGSHrF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 03:47:05 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021F822B34
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 00:47:02 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 39C431030DBF1;
        Tue, 19 Jul 2022 09:47:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 149C44ABFE; Tue, 19 Jul 2022 09:47:01 +0200 (CEST)
Date:   Tue, 19 Jul 2022 09:47:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Lindahl <jensctl@gmail.com>
Subject: Re: [PATCH] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer
 deref for non DMA transfers
Message-ID: <20220719074701.GA26268@wunner.de>
References: <20220719072234.2782764-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719072234.2782764-1-mkl@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[+cc Jens, Florian, Stefan, Mark]

On Tue, Jul 19, 2022 at 09:22:35AM +0200, Marc Kleine-Budde wrote:
> In case a IRQ based transfer times out the bcm2835_spi_handle_err()
> function is called. Since commit 1513ceee70f2 ("spi: bcm2835: Drop
> dma_pending flag") the TX and RX DMA transfers are unconditionally
> canceled, leading to NULL pointer derefs if ctlr->dma_tx or
> ctlr->dma_rx are not set.
> 
> Fix the NULL pointer deref by checking that ctlr->dma_tx and
> ctlr->dma_rx are valid pointers before accessing them.
> 
> Fixes: 1513ceee70f2 ("spi: bcm2835: Drop dma_pending flag")
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Link: https://lore.kernel.org/linux-spi/20220603142340.42271-1-jensctl@gmail.com/
