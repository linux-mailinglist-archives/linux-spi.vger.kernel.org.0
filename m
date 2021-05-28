Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCD393F1E
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhE1JCm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 05:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236204AbhE1JCl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 May 2021 05:02:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54B4F6124B;
        Fri, 28 May 2021 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622192467;
        bh=LX4wRgG+plCD772Xo0oFKi57FByZIj36CE32DXUspYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vjBJwhYvIIVENXGQW/yFXfPFFkmeo2Tbi+fnV8/G4i5HmO9x9RNS3Blb/Sq+RgBLo
         QGYZwspwSFCkBhPzDrvMiR2b4kLTYUvkxRuoOdArSkMcUy5eJFBZzNXktFrvUFsrp3
         fRC5Lu/n+yMHZsmmMArqNyQ47fhbmL21hxNynK3M=
Date:   Fri, 28 May 2021 11:01:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sasha Levin <sashal@kernel.org>,
        "William A. Kennington III" <wak@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4.9-stable] spi: Fix use-after-free with devm_spi_alloc_*
Message-ID: <YLCxUJKVLB5BP4Jy@kroah.com>
References: <20210528062343.GA29343@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528062343.GA29343@wunner.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 28, 2021 at 08:23:43AM +0200, Lukas Wunner wrote:
> Dear Greg, Dear Sasha,
> 
> please consider applying the patch below to v4.9-stable.

Please always cc: stable@vger.kernel.org for stuff you want queued up so
that we do not miss them...

thanks,

greg k-h
