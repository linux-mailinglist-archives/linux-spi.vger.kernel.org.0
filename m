Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E957BF078
	for <lists+linux-spi@lfdr.de>; Tue, 10 Oct 2023 03:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378945AbjJJBsS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Oct 2023 21:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379383AbjJJBsR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Oct 2023 21:48:17 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9024DA3
        for <linux-spi@vger.kernel.org>; Mon,  9 Oct 2023 18:48:14 -0700 (PDT)
Received: (qmail 167754 invoked by uid 1000); 9 Oct 2023 21:48:13 -0400
Date:   Mon, 9 Oct 2023 21:48:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Randy Li <ayaka@soulik.info>
Cc:     linux-usb@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: a bulk urb with both PIO and DMA buffer?
Message-ID: <e00135a7-2f85-41d2-9b00-1dcaf70ee3e4@rowland.harvard.edu>
References: <38fbd171-2d88-4caf-9386-2c8ab45db643@soulik.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38fbd171-2d88-4caf-9386-2c8ab45db643@soulik.info>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 10, 2023 at 05:53:38AM +0800, Randy Li wrote:
> Hello
> 
> I am trying to write a driver for a USB-SPI adapter(WCH347). The protocol of
> this chip would be consist with two parts, operate code and payload length
> would be the first part. SPI framework could prepare the sg_table for the
> second part which is the payload.
> 
> It is worth to do dma transfer for the second part of a bulk packet, but I
> have to prepend a small buffer before it. Then I have to copy the
> scatterlist from the sg_table to append to a new scatter list, that costs
> CPU a lot.
> 
> I wonder if there is a way that I could construct a bulk packet with two
> URBs or anyway to make the URB first try a bytes of PIO then DMA?

It is not possible to do either of those things.

However, it is possible to modify the sg_table by adding a new element 
at the start (or else create a new sg_table that starts with a new 
element and then includes the original sg_table).  The new element can 
point to a buffer in which you store the operate code and payload 
length.  Once that's finished, you can use SG for the entire URB.

Alan Stern
