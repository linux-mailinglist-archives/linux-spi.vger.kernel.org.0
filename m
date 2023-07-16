Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7995C7550DE
	for <lists+linux-spi@lfdr.de>; Sun, 16 Jul 2023 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGPTMI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 16 Jul 2023 15:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGPTMH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 16 Jul 2023 15:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5287E48;
        Sun, 16 Jul 2023 12:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42F5560E26;
        Sun, 16 Jul 2023 19:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54908C433C8;
        Sun, 16 Jul 2023 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689534719;
        bh=I97EntxvAI6ZJFC9qtj5pdLgbSV02e0Kmj+FjqLB2oU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zb2QNE3VosAnExtJLtvncBw+bblddvd0dPKuaCVD46l7/ddTGki5go3YzNMv69pYO
         tEwa7IfF5Mp8kb8hZ17OGYD6xFsmkz+jCvbfGq0zQMgL3Tr83wwHauUTjyX1VjmgKN
         2BT6XyLpdiqpww5IToOlmbZv1mYmpN+ii2L/OMUw=
Date:   Sun, 16 Jul 2023 21:11:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-stable <stable@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        BERGER Olivier <olivier.berger@csgroup.eu>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>,
        CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>
Subject: Re: Backport to 4.14 and 4.19 commits 24c363623361 and 17ecffa28948
 and a798a7086c38
Message-ID: <2023071648-filling-unscented-d998@gregkh>
References: <5201aa35-5855-53ec-d123-1a88523971da@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5201aa35-5855-53ec-d123-1a88523971da@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 13, 2023 at 03:34:10PM +0000, Christophe Leroy wrote:
> Hi,
> 
> Could you please backport the three following commits to 4.14 and 4.19:
> 
> 24c363623361 ("spi: spi-fsl-spi: remove always-true conditional in 
> fsl_spi_do_one_msg")
> 17ecffa28948 ("spi: spi-fsl-spi: relax message sanity checking a little")
> a798a7086c38 ("spi: spi-fsl-spi: allow changing bits_per_word while CS 
> is still active")
> 
> Those three commits (the last one indeed) are needed to overcome a 
> problem introduced in 4.14.230 by commit 42c04316d927 ("spi: fsl-cpm: 
> Use 16 bit mode for large transfers with even size"), which leads to the 
> following error in certain cases:
> 
> [  174.900526] at25 spi0.3: bits_per_word/speed_hz should be same for 
> the same SPI transfer
> [  174.911844] spi_master spi0: failed to transfer one message from queue
> [  366.639467] INFO: task od:406 blocked for more than 120 seconds.
> [  366.645155]       Not tainted 4.14.320-s3k-dev-dirty #342
> [  366.652996] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  489.519450] INFO: task od:406 blocked for more than 120 seconds.
> [  489.525156]       Not tainted 4.14.320-s3k-dev-dirty #342
> [  489.532915] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> ...

Now queued up, thanks.

greg k-h
