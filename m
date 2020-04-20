Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A80D1B0E85
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgDTOgy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 10:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgDTOgy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Apr 2020 10:36:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B0620735;
        Mon, 20 Apr 2020 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587393413;
        bh=cNnhSQRcFA0Sj002AyZDg4SB/tTuyxPaam4FLSdajLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7OOEk9GRTrdn4X0FbyAQoc6E9BBl7zetM4G7vZqWMqav6EQhxJl6DyS1YWKn0i82
         zXJ8MtX/Fny4iKRxYMI6zsPmtjegy6qeZ99mJLaLir4AQOo6iTTgnDIJ/v/GyrMIXb
         G4vb0PcT3m2a28gXg7C+1gzlB3VD7puTfSgmyJsE=
Date:   Mon, 20 Apr 2020 22:36:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, eha@deif.com,
        angelo@sysam.it, andrew.smirnov@gmail.com, gustavo@embeddedor.com,
        weic@nvidia.com, mhosny@nvidia.com, michael@walle.cc,
        peng.ma@nxp.com
Subject: Re: [PATCH v5 11/12] arm64: dts: ls1028a: Specify the DMA channels
 for the DSPI controllers
Message-ID: <20200420143640.GA32419@dragon>
References: <20200318001603.9650-1-olteanv@gmail.com>
 <20200318001603.9650-12-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318001603.9650-12-olteanv@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 18, 2020 at 02:16:02AM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> LS1028A has a functional connection to the eDMA module. Even if the
> spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the slots
> in the DMAMUX for connecting the eDMA channels to the 3 DSPI
> controllers.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied, thanks.
