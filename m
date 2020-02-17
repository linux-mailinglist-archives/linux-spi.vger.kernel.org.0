Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62247160A49
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2020 07:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgBQGQo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 01:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgBQGQo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Feb 2020 01:16:44 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF73020679;
        Mon, 17 Feb 2020 06:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581920203;
        bh=DLvMATAzEWVQjYRixiWO3+rDmcBnoRjcRpX5U858a+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEO1sA0guMEqD++vNYCPcJAPujIvm6A5mDDD/+UcI6BBqPrjR7K+oVw1kCzr2uZh6
         TSBCI8DSgGRjikqFJqbTr6YELYwhxKZw20MZt2nesBP7DwU4SMqftXE18I1FI6nKk2
         N5AVGfVeSNY4tu3wgsrU9gRaXwKeQ3rC6/2HyjhQ=
Date:   Mon, 17 Feb 2020 14:16:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        marcel.ziswiler@toradex.com, rjones@gateworks.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        gary.bisson@boundarydevices.com, angus@akkea.ca,
        pramod.kumar_1@nxp.com, rabeeh@solid-run.com,
        cosmin.stoica@nxp.com, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 2/4] arm64: dts: freescale: Add i.MX8MP dtsi support
Message-ID: <20200217061629.GA6659@dragon>
References: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
 <1581425307-18567-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581425307-18567-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 11, 2020 at 08:48:25PM +0800, Anson Huang wrote:
> The i.MX8M Plus Media Applications Processor is part of the growing
> mScale family targeting the consumer and industrial market. It brings
> an effective Machine Learning and AI accelerator that enables a new
> class of applications. It is built in Samsung 14LPP to achieve both
> high performance and low power consumption and relies on a powerful
> fully coherent core complex based on a quad core ARM Cortex-A53 cluster
> and Cortex-M7 low-power coprocessor, audio digital signal processor,
> machine learning and graphics accelerators.
> 
> Add the basic dtsi support for i.MX8MP.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied 2 ~ 4, thanks.
