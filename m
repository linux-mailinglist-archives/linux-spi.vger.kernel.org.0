Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DCD33EB13
	for <lists+linux-spi@lfdr.de>; Wed, 17 Mar 2021 09:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCQIH2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Mar 2021 04:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhCQIHS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Mar 2021 04:07:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C50F64F7F;
        Wed, 17 Mar 2021 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615968438;
        bh=JjS5m2yPDHpWdfC2ifQGepgziRsPL5CojQq5WXxi9Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXByjGhGztc/4fmMD4fV5d6jRzqTT3QDvfY8ulWhEa+lQLGTw/qYc70d35tQYUc5G
         4OdJ24aptdNgwu7sEEMpKrdRhJA/D5CVARcJHa9sX6A3aKaBEfz+Rz9ibB9PbURGK1
         UFROHPl5rjZGMrVBl1uAT8O/IW8Jp6HVz2i0bAmpfe6fNyA4xnhqVgmbLzX3jVhIhM
         o6qNEIO75bUxPgk/gxh2LkeFe2vWCh31EcoyPPSXz60Mt/0yle+v9jGRLebi0PoNuj
         M+l1SxUUY2nF7olTPOBB8u7RYmYFYXCE6DEJRYFrXpBNRKLWtiAMMRHB+iNqbPglUQ
         sAHJzTjtfndMg==
Date:   Wed, 17 Mar 2021 16:07:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] enable flexspi support on imx8mp
Message-ID: <20210317080712.GU11246@dragon>
References: <20210316075928.1763460-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316075928.1763460-1-hs@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 16, 2021 at 08:59:26AM +0100, Heiko Schocher wrote:
> add compatible entry in nxp_fspi driver for imx8mp
> 
> @Shawn: If this series is accepted, can you apply the DTS patches from
> series v2?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643292.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643293.html

Sure.  I will pick them up after this series gets accepted.

Shawn
