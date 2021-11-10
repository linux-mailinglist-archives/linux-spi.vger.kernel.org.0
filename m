Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ED744C0D5
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 13:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhKJMKc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 07:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhKJMKb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Nov 2021 07:10:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8E8561251;
        Wed, 10 Nov 2021 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636546064;
        bh=7C4Nj7RHwXKz9a2aaWHM2yb5ZGQ1h9dPHYMioO9w+ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sq2f61YdWOsUqGV4EurDHGBnoO+jMzPx+KeUm4k16HC05lp6WS1vaiOWq8VUWL7XA
         Or4d//z60sP9i0zUM9N8RLdnLk0uBzZHk7/EQJwOiVjBYIL39BHt77TEbUm2JQrzTu
         heOUHTFQMmxjDTWTBMNy9gTnINNWtoFPk9Nr2X/D4TmLuDlSCOr3bsX1H5YWyVK4WM
         FiW8M5Q4P24XxFU+o1wpeIkDb+8i1MA1I6NV322WsSC8VvyLfSndlXqOoD3XZNTcMZ
         qZMLX5HHDUsgx5f0rhDsoPB3eRxVkny8sEQnrMhfM2FJOzKPjbpEHROVTYrKllA18L
         tHhatk9k0q3RA==
Date:   Wed, 10 Nov 2021 17:37:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: fix error handling in
 spi_geni_grab_gpi_chan()
Message-ID: <YYu2DD3tFyxMB5Gz@matsya>
References: <20211110073935.GA5176@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110073935.GA5176@kili>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10-11-21, 10:39, Dan Carpenter wrote:
> This code has several issues:
> 1) It passes IS_ERR() to dev_err_probe() instead of PTR_ERR().
> 2) It always prints an error message, even when it succeeds.
> 3) The "if (ret < 0) {" conditions are never true.
> 4) If requesting "mas->tx" fails then it sets "mas->rx" to NULL but the
>    intention was to set "mas->tx" to NULL.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
