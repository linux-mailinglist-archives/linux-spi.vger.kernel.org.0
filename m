Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB4E577ABA
	for <lists+linux-spi@lfdr.de>; Mon, 18 Jul 2022 08:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiGRGCL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Jul 2022 02:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiGRGCK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Jul 2022 02:02:10 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E2A1057C
        for <linux-spi@vger.kernel.org>; Sun, 17 Jul 2022 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=Kanh781UymksAyGUugmQj8P1S8W1X2YktbcM9+VR/60=;
        b=VBQ4pHVTdgeGeMKYSiX0Iu5QJpSgQ6fleLAfnAHPgtLKhB6ylKf7a4Eypl5nR5o6Hh/fqe5nt4Hhb
         O5xHTfWoAKql5HgshsyT1LPw3N5tdHAXIau2WJZh6cPfjBtzPeAcHnM4RBFZJSscnK7UZKZLe8jdfs
         kIiv5rTsJZAkbVX52ptH4HL/otBOH6iWZJD5IyTUz1ki5Z9FjCJlU4ZNDNfge7QKgjshBMjT6qOQ1R
         FFbkg28OyA+CFl3sOMsGGTn4o3SbtSNoPFtICBPVotO3sn7ehS22nwFftrUJD/hYgvwmZJYq0cF5uV
         HePpOLKBkcQRWjnaNKLSVdAyzIR369g==
X-MSG-ID: 24694fd2-065f-11ed-9051-0050569d2c73
Date:   Mon, 18 Jul 2022 08:02:01 +0200
From:   David Jander <david@protonic.nl>
To:     Thomas Kopp <thomas.kopp@microchip.com>
Cc:     <andrew@lunn.ch>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <mkl@pengutronix.de>
Subject: Re: [PATCH v3 00/11] Optimize spi_sync path
Message-ID: <20220718080201.5799c036@erd992>
In-Reply-To: <20220715141342.12330-1-thomas.kopp@microchip.com>
References: <20220621061234.3626638-1-david@protonic.nl>
        <20220715141342.12330-1-thomas.kopp@microchip.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Thomas,

On Fri, 15 Jul 2022 16:13:42 +0200
Thomas Kopp <thomas.kopp@microchip.com> wrote:

> Hi David,
>  
> some numbers after testing your patch on a RPI 5.15.y vs 5.19rc6 and the
> mcp2518fd:
> 
> Two Backtoback SPI transfers with 9 byte each went from 78us to 36us! All
> metrics improved (cs to first clock cyle, last clock cycle to cs, and delay
> between two transfers). That's a great help for the mcp driver (or any
> similar SPI device).
> 
> Thanks for your work on this!

Thanks a lot for testing and reporting! It is very encouraging to hear first
reports of people confirming the gains I intended to accomplish.

Best regards,

-- 
David Jander
Protonic Holland.
