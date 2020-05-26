Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3361E1C61
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgEZHjS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 03:39:18 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:47841 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEZHjS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 03:39:18 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0AA5F3000D90F;
        Tue, 26 May 2020 09:39:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CFBA4F6B3D; Tue, 26 May 2020 09:39:13 +0200 (CEST)
Date:   Tue, 26 May 2020 09:39:13 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
Message-ID: <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
References: <cover.1590408496.git.lukas@wunner.de>
 <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
 <20200525132143.GX1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525132143.GX1634618@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 04:21:43PM +0300, Andy Shevchenko wrote:
> Tsuchiya Yuto, I'm going to apply this series as preparatory to my
> WIP patch in topic/spi/reload branch in my kernel tree on GitHub,
> so, it would be possible to see if this + my patch fixes crashes
> on removal. Though, please test this separately from my stuff to
> clarify if it fixes or not issue you have seen.

You also need to cherry-pick commit 84855678add8 ("spi: Fix controller
unregister order") from spi/for-next onto your topic/spi/reload branch
for reloading to work correctly.

Alternatively, rebase your topic/spi/reload branch and redo the merge
from spi/for-next.  (You've merged spi/for-next into your branch on
May 14, but the commit was applied by Mark on May 20.)

Thanks,

Lukas
