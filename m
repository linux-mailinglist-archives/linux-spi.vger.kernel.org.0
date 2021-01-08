Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354642EEF53
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbhAHJS7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 04:18:59 -0500
Received: from tux.runtux.com ([176.9.82.136]:57126 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbhAHJS7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 Jan 2021 04:18:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id DCA666F0DC;
        Fri,  8 Jan 2021 10:18:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qsUDoNvo58W9; Fri,  8 Jan 2021 10:18:17 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 646FF6EF54;
        Fri,  8 Jan 2021 10:18:16 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 068AF46C; Fri,  8 Jan 2021 10:18:15 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:18:15 +0100
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Fix SPI Chipselect/Clock bug for sun6i
Message-ID: <20210108091815.h35ane6xe6bzhje2@runtux.com>
References: <20201226095845.c65lhsmluddvwxsl@runtux.com>
 <20210108085855.p255fioaax4zin4q@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108085855.p255fioaax4zin4q@gilmour>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 08, 2021 at 09:58:55AM +0100, Maxime Ripard wrote:
> 
> Unfortunately, without the author's Signed-off-by (and yours), we can't
> merge that patch.

Thanks for the Reply. I've researched more and found out who the
probable Author of the patch is. I've tried to contact him via Email,
I'll follow up with correct signed-off etc when I've got permission.

Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
