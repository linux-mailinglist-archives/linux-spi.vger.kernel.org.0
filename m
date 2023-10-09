Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37F7BED9D
	for <lists+linux-spi@lfdr.de>; Mon,  9 Oct 2023 23:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378790AbjJIVxp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Oct 2023 17:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378789AbjJIVxo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Oct 2023 17:53:44 -0400
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B579D
        for <linux-spi@vger.kernel.org>; Mon,  9 Oct 2023 14:53:43 -0700 (PDT)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id B869F2FEB47;
        Tue, 10 Oct 2023 06:53:37 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info B869F2FEB47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1696888417; bh=faB/WYxE24l8xQ7I8lvT1dFlajYQvzyuiqUittzgSkI=;
        h=Date:To:From:Subject:Cc:From;
        b=LFrpe3Y9PlAQG4KXEa2owmaIRIJRJugHM6oN16KtQgV8KOMYGEl5imSpzodayMdaT
         N6EzGt5mmmTPvz5HPZf4TYoIQtc/qMfgDdNSu0DVynGPNEmouUJpoQmpdh7fPDVcWL
         yLsLEU/PdsfPt2F9ujIzgea0hYlWucPgHznvDdZA=
Message-ID: <38fbd171-2d88-4caf-9386-2c8ab45db643@soulik.info>
Date:   Tue, 10 Oct 2023 05:53:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-usb@vger.kernel.org
From:   Randy Li <ayaka@soulik.info>
Subject: a bulk urb with both PIO and DMA buffer?
Cc:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello

I am trying to write a driver for a USB-SPI adapter(WCH347). The 
protocol of this chip would be consist with two parts, operate code and 
payload length would be the first part. SPI framework could prepare the 
sg_table for the second part which is the payload.

It is worth to do dma transfer for the second part of a bulk packet, but 
I have to prepend a small buffer before it. Then I have to copy the 
scatterlist from the sg_table to append to a new scatter list, that 
costs CPU a lot.

I wonder if there is a way that I could construct a bulk packet with two 
URBs or anyway to make the URB first try a bytes of PIO then DMA?

Sincerely

Randy

