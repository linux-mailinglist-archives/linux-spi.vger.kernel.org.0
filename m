Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D04D518EC53
	for <lists+linux-spi@lfdr.de>; Sun, 22 Mar 2020 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCVUyd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Mar 2020 16:54:33 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:56748 "EHLO
        3.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgCVUyd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Mar 2020 16:54:33 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Mar 2020 16:54:32 EDT
Received: from player787.ha.ovh.net (unknown [10.108.42.75])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 3BA6694FE9
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2020 21:46:21 +0100 (CET)
Received: from etezian.org (213-243-141-64.bb.dnainternet.fi [213.243.141.64])
        (Authenticated sender: andi@etezian.org)
        by player787.ha.ovh.net (Postfix) with ESMTPSA id B249710DAEC38;
        Sun, 22 Mar 2020 20:46:03 +0000 (UTC)
Date:   Sun, 22 Mar 2020 22:46:02 +0200
From:   Andi Shyti <andi@etezian.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] spi: spi-s3c24xx: Replace zero-length array with
 flexible-array member
Message-ID: <20200322204602.GA131880@jack.zhora.eu>
References: <20200320232556.GA24989@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320232556.GA24989@embeddedor.com>
X-Ovh-Tracer-Id: 14887774468655923905
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudegiedgudegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucffohhmrghinhepghhnuhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpddvudefrddvgeefrddugedurdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Gustavo,

On Fri, Mar 20, 2020 at 06:25:56PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

yes, thank you!

Reviewed-by: Andi Shyti <andi@etezian.org>

Andi
