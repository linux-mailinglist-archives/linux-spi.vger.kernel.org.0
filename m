Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1013754CAF4
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 16:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiFOOOX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353163AbiFOOOB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 10:14:01 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4FC192A5
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=cU63ym4X53fKIlrrBQ5m80vzLbOrXAj7eH4jQuBfPhk=;
        b=rZ8G/A5cANaBOWo4GVlXVEeUnFjD8b9XrMjf22SJBxIeVipXMcePbxrPNZGtowJ42iuLFOISsjPL2
         8QlIRvVq5/HA24GOyYAjbkpFm5DWd9e5LpNBK78kv5HExvj1b8s/QZVD5flsM7DB3EH0pY8Al4ZLwl
         QKH9HutLgnd4eZD3zxsUi24J9ZEaocpYVt43layo8RTuRzkNQg++Gf5f3Sp9P1DdVcmHSJG4mGk4sa
         6UtwMEDSQbeTocZPH8DgbGgBBvcbrOT7FeKhAyd/utPxoNziBT0ZFiiFxKguKhaDfkXQC1xpm80cF/
         H69P1PdmSNZMyFW/0bIEHRZDcz0KE/g==
X-MSG-ID: 653125ad-ecb5-11ec-ba03-0050569d3a82
Date:   Wed, 15 Jun 2022 16:13:56 +0200
From:   David Jander <david@protonic.nl>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <20220615161356.21bf749d@erd992>
In-Reply-To: <20220615133113.ylwenlzpkv2na25z@pengutronix.de>
References: <20220615124634.3302867-1-david@protonic.nl>
        <20220615133113.ylwenlzpkv2na25z@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Jun 2022 15:31:13 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 15.06.2022 14:46:23, David Jander wrote:
> > These patches optimize the spi_sync call for the common case that the
> > worker thread is idle and the queue is empty. It also opens the
> > possibility to potentially further optimize the async path also, since
> > it doesn't need to take into account the direct sync path anymore.
> > 
> > As an example for the performance gain, on an i.MX8MM SoC with a SPI CAN
> > controller attached (MCP2518FD), the time the interrupt line stays
> > active (which corresponds roughly with the time it takes to send 3
> > relatively short consecutive spi_sync messages) is reduced from 98us to
> > only 72us by this patch.
> > 
> > A note about message ordering:
> > 
> > This patch series should not change the behavior of message ordering when
> > coming from the same context. This means that if a client driver issues
> > one or more spi_async() messages immediately followed by a spi_sync()
> > message in the same context, it can still rely on these messages being
> > sent out in the order they were fired.  
> 
> Which git branch to use as the base?

Sorry, forgot to mention: spi for-next:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

This is because it relies on previous patches that have been applied there.

-- 
David Jander
