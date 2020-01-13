Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC7139BF3
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 22:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgAMVzK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 16:55:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36885 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgAMVzK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 16:55:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so10519095otn.4
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 13:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxveT8kmVAy+6NNs/m6VYBrLz6raLXBMbZxaVD7AKwA=;
        b=NZ+l6tNcNOpBzWMsZwMQbnRWOCqhRNoXhY2XAVjZpMHRGg2BWbGzcmVp4fhjSpjWpq
         Rlnaue0kof86XO5ULTm85omgyJXsm4tU+xtzFF2Mk6fimCkTp7OJfs/sbkjt22TH6ka5
         fKna/Oh4ysq2rJCSF2KQeEnARK/j2MjRAGhUooDY1BjYIVe5yyYZjEP2OiMRQ2tkLQ+r
         m/C22kkeSaGl6q07cof7Z5DTEjcrcfAQQfjA1rYQS/t6OCvBQ815SBsZ1H5BRoOxKt9P
         6PS6vHx06E9kol9UUdSD9Yvn3mzm+tyT3Y43sOAQd3+WB5aw/zmgyFEO59ZdUe3CZCcw
         B1dw==
X-Gm-Message-State: APjAAAXxFfCZ2QTZww9QO+YpnHS7uGVzNPisPj9ZcKs1R3XnY8Kt2fKl
        UDmcItktCzV7v8fFiVWcoMAPpKI=
X-Google-Smtp-Source: APXvYqxdW8mTZtmhc3CLA0AyGqtsEabFA95ZApgtMNDKaPXomnCk0xMkK6Pj3r9tPj+BoRHGUakRHw==
X-Received: by 2002:a9d:4d8d:: with SMTP id u13mr13944513otk.299.1578952509267;
        Mon, 13 Jan 2020 13:55:09 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s83sm3938102oif.33.2020.01.13.13.55.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:55:09 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 15:47:36 -0600
Date:   Mon, 13 Jan 2020 15:47:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 7/7] dt-bindings: arm: imx: Add the i.MX8MP EVK board
Message-ID: <20200113214736.GA12301@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-7-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-7-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 13 Jan 2020 13:33:22 +0800, Anson Huang wrote:
> Add board binding for i.MX8MP EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
