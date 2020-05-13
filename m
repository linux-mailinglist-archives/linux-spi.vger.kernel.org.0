Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FBC1D1231
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgEMMFS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 08:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgEMMFS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 May 2020 08:05:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C33206CC;
        Wed, 13 May 2020 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589371516;
        bh=kRyvSDRu3xjTSv6TMutjJNKJ8OrB0G86iDgdu0a63/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvpJrovzLbh7w/k9JpHuPD6Sh2soLQDQO81m2EDh9oogCrpNQ66XE0og7esrXpkpt
         9oy83Adgg5ANiZMqBthweHxV5gDfgP8ug8LMq8NJotSrmhP0m+kjWsraMEEL9mhRmk
         FzpHS7rtPLl7Iq74RpfTfr0tGE9ZmZZzvPnjZZtc=
Date:   Wed, 13 May 2020 14:05:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: usb: ehci: Add missing 2nd register
 region
Message-ID: <20200513120513.GA1002370@kroah.com>
References: <20200512204543.22090-1-robh@kernel.org>
 <20200512204543.22090-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512204543.22090-2-robh@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 12, 2020 at 03:45:40PM -0500, Rob Herring wrote:
> The 'ibm,usb-ehci-440epx' compatible has a 2nd 'reg' region, but the
> schema says there is only 1 region. Fix this.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack, dependency for patch 5.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
