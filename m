Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD039430D
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhE1M6T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 08:58:19 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:49399 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhE1M6T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 08:58:19 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1958930000349;
        Fri, 28 May 2021 14:56:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0CBC2132D6A; Fri, 28 May 2021 14:56:42 +0200 (CEST)
Date:   Fri, 28 May 2021 14:56:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        "William A. Kennington III" <wak@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4.9-stable] spi: Fix use-after-free with devm_spi_alloc_*
Message-ID: <20210528125642.GD17551@wunner.de>
References: <20210528062343.GA29343@wunner.de>
 <YLCxUJKVLB5BP4Jy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLCxUJKVLB5BP4Jy@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 28, 2021 at 11:01:04AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 28, 2021 at 08:23:43AM +0200, Lukas Wunner wrote:
> > Dear Greg, Dear Sasha,
> > 
> > please consider applying the patch below to v4.9-stable.
> 
> Please always cc: stable@vger.kernel.org for stuff you want queued up so
> that we do not miss them...

Sorry about that.  I've just amended the Cc: header as requested and
bounced the two messages to stable@, they're visible on lore.kernel.org
already.

Thanks,

Lukas
