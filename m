Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C589038A512
	for <lists+linux-spi@lfdr.de>; Thu, 20 May 2021 12:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhETKMp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 May 2021 06:12:45 -0400
Received: from tux.runtux.com ([176.9.82.136]:43808 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbhETKKm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 May 2021 06:10:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 10F896EF2C;
        Thu, 20 May 2021 12:00:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id czpMl34TZC6B; Thu, 20 May 2021 12:00:35 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 22A776EFFE;
        Thu, 20 May 2021 12:00:06 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id AD6A0471; Thu, 20 May 2021 12:00:05 +0200 (CEST)
Date:   Thu, 20 May 2021 12:00:05 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Fix SPI Chipselect/Clock bug for sun6i
Message-ID: <20210520100005.vk4vzd7u6sqcogn3@runtux.com>
References: <20201226095845.c65lhsmluddvwxsl@runtux.com>
 <20210108085855.p255fioaax4zin4q@gilmour>
 <20210108091815.h35ane6xe6bzhje2@runtux.com>
 <20210111161004.a6suk2vreuslyj4m@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111161004.a6suk2vreuslyj4m@gilmour>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 11, 2021 at 05:10:04PM +0100, Maxime Ripard wrote:
> On Fri, Jan 08, 2021 at 10:18:15AM +0100, Ralf Schlatterbeck wrote:
> > On Fri, Jan 08, 2021 at 09:58:55AM +0100, Maxime Ripard wrote:
> > > 
> > > Unfortunately, without the author's Signed-off-by (and yours), we can't
> > > merge that patch.
> > 
> > Thanks for the Reply. I've researched more and found out who the
> > probable Author of the patch is. I've tried to contact him via Email,
> > I'll follow up with correct signed-off etc when I've got permission.
> 
> Great, thanks!
> Maxime

I've finally got permission :-) I'll re-submit in a separate thread.

Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
