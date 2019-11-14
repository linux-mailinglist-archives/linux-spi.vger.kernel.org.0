Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38CCFC027
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2019 07:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfKNG13 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Nov 2019 01:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfKNG13 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Nov 2019 01:27:29 -0500
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58FEB20709;
        Thu, 14 Nov 2019 06:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573712848;
        bh=8hzwCt1v1NdUbhpvZ5TqJJzC/rhyT2NofD4G90JdjLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cYO1tXkg7eFtMudQwH2gz+1sxd41wi5O+dYXb27KzReNitNkK2hGYvpBKBbfIlfka
         W5oCDUvwBSb71gGh8s4FySNrNUuXK0JtfMmwt5TdA05AYDuOrMnPs8h6Y881txMUW3
         pqU0OaVbwouBVxzBLz6eyCpHuwp1lS7W5xOsENkw=
Received: by mail-lj1-f180.google.com with SMTP id y23so5312506ljh.10;
        Wed, 13 Nov 2019 22:27:28 -0800 (PST)
X-Gm-Message-State: APjAAAXYPZk2D70tYJGa/v1G0ei0n133LQFEu9BXwkTbuayK6yBnJ7Vg
        X/JqafHeThhjfGbFf4aDwoca0VJc6V3kj3OWeEQ=
X-Google-Smtp-Source: APXvYqxLS447eYAoTkwwrZ8NQanUwXVmQzqjcphyQAiiCVNGGA//5Ap3b/PqZTjA8RvqQCvN6M1AOyz+5i1QDL1Kr1E=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr5294560ljj.93.1573712846541;
 Wed, 13 Nov 2019 22:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20191113094256.1108-1-peter.ujfalusi@ti.com> <20191113094256.1108-8-peter.ujfalusi@ti.com>
In-Reply-To: <20191113094256.1108-8-peter.ujfalusi@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 14 Nov 2019 14:27:15 +0800
X-Gmail-Original-Message-ID: <CAJKOXPe_vfDjJSbVOxFFDFO3OWPLFr_UffCqVZb4ahGF57aVYA@mail.gmail.com>
Message-ID: <CAJKOXPe_vfDjJSbVOxFFDFO3OWPLFr_UffCqVZb4ahGF57aVYA@mail.gmail.com>
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, radu_nicolae.pirea@upb.ro, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linus.walleij@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        Andi Shyti <andi@etezian.org>, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, vkoul@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alexandre.belloni@bootlin.com, linux-arm-msm@vger.kernel.org,
        kgene@kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Nov 2019 at 17:42, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
>         dma_request_chan(dev, name)
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
