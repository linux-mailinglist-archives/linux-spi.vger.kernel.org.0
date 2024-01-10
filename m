Return-Path: <linux-spi+bounces-387-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C18295C4
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jan 2024 10:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686881C20C7A
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jan 2024 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4243B1B7;
	Wed, 10 Jan 2024 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XKYb0enl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C383B199
	for <linux-spi@vger.kernel.org>; Wed, 10 Jan 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 82CF52288E;
	Wed, 10 Jan 2024 10:07:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1704877657;
	bh=SXs4Ffbi8vhVaSL8hbtCzmZTAxlbp9hegKYApf5L41k=; h=From:To:Subject;
	b=XKYb0enlHLUi7kxB6SMxYYFMkPuiG+9SkBgp2QfQHtu+APSDqcjisxLMBeVkYjQic
	 R4+Sux6QtlSEzTDugICB4HQmtPbCfGz+vQweIB4j9szi9qcBDQi9LTZ8OlIL3ojr8Y
	 +bUpSD1z8oeh/XUDBcbtHAermDkB8EE3aBbap4nSLdi61p/SwKGq0jEsqJhlHxjKIz
	 yfT+nDqPYwE8o3nMcWkY8T0slHVGqik472jm4fblMbrD6lr8/AeuNZ2HR+mjgVIe4H
	 o/ku2kwQA1O8TpnLnrTRXnNvGLS4TmRjg939t2ikB/aQlLljuL+vHaLwKZzUEEIGC9
	 QdP0MJs/3+jaA==
Date: Wed, 10 Jan 2024 10:07:33 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] spi: spi-imx: Use dev_err_probe for failed DMA
 channel requests
Message-ID: <20240110090733.GA5569@francesco-nb>
References: <20240110085403.457089-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110085403.457089-1-alexander.stein@ew.tq-group.com>

On Wed, Jan 10, 2024 at 09:54:03AM +0100, Alexander Stein wrote:
> If dma_request_chan() fails, no error is shown nor any information is
> shown in /sys/kernel/debug/devices_deferred if -EPROBE_DEFER is returned.
> Use dev_err_probe to fix both problems.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


