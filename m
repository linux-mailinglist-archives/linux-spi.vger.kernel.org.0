Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B213B6E30
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 08:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhF2GUx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 02:20:53 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39801 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhF2GUx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Jun 2021 02:20:53 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id EBE1B30000349;
        Tue, 29 Jun 2021 08:18:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D72B13CAFDF; Tue, 29 Jun 2021 08:18:24 +0200 (CEST)
Date:   Tue, 29 Jun 2021 08:18:24 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "William A. Kennington III" <wak@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] spi: <linux/spi/spi.h>: add missing struct kernel-doc
 entry
Message-ID: <20210629061824.GA21978@wunner.de>
References: <20210628210520.5712-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628210520.5712-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jun 28, 2021 at 02:05:20PM -0700, Randy Dunlap wrote:
> Fix kernel-doc warning in spi.h by adding the missing kernel-doc entry
> and also correct the original comment so that they both indicate the
> correct polarity of the flag.
> 
> ../include/linux/spi/spi.h:673: warning: Function parameter or member 'devm_allocated' not described in 'spi_controller'
> 
> Fixes: 794aaf01444d ("spi: Fix use-after-free with devm_spi_alloc_*")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: William A. Kennington III <wak@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org

Reviewed-by: Lukas Wunner <lukas@wunner.de>
