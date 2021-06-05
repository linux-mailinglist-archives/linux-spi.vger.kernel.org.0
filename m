Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D63339C8FE
	for <lists+linux-spi@lfdr.de>; Sat,  5 Jun 2021 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFEOTC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Jun 2021 10:19:02 -0400
Received: from 0.mx.nanl.de ([217.115.11.12]:51780 "EHLO 0.mx.nanl.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEOTC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 5 Jun 2021 10:19:02 -0400
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jun 2021 10:19:02 EDT
Received: from [217.115.11.14] (unknown [217.115.11.14])
        by 0.mx.nanl.de (Postfix) with ESMTPSA id 2279D40302;
        Sat,  5 Jun 2021 14:03:49 +0000 (UTC)
Subject: Re: [PATCH 1/1] spi-sun6i: Fix chipselect/clock bug
To:     Ralf Schlatterbeck <rsc@runtux.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mirko Vogt <mirko-dev|linux@nanl.de>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
 <20210521173011.1c602682@slackpad.fritz.box>
 <20210521201913.2gapcmrzynxekro7@runtux.com> <YK0LR3077RUsSYti@sirena.org.uk>
 <20210527113920.ncpzrpst2d6rij3t@runtux.com>
From:   Mirko Vogt <mirko-dev|linux@nanl.de>
Message-ID: <0418aba2-6bca-8de1-9f72-2fb10007fc81@nanl.de>
Date:   Sat, 5 Jun 2021 16:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527113920.ncpzrpst2d6rij3t@runtux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 5/27/21 1:39 PM, Ralf Schlatterbeck wrote
> OK, let me know if I should repost in new thread with increased version
> number in the subjec
Assuming this wasn't answered yet: was this just a comment for further 
patches and things are going their way or should it indeed be resent as 
new thread/version with respective changes applied?
Can I do something to help / resolve this?

Have a nice weekend

   mirko
