Return-Path: <linux-spi+bounces-2069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E8688EF9A
	for <lists+linux-spi@lfdr.de>; Wed, 27 Mar 2024 20:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99351C2D35C
	for <lists+linux-spi@lfdr.de>; Wed, 27 Mar 2024 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216BC12FB28;
	Wed, 27 Mar 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5HWjmoP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4212D20E
	for <linux-spi@vger.kernel.org>; Wed, 27 Mar 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569396; cv=none; b=T01nU1qkibh9ZJCNkD7z97RJHOHmK0mX31yVoeQNYunLpP9kOnwDHbLalOoD8qzqxIdG15oQV1W57ND1oApHP+v8CTHIlZbdoH9fFcesLx82sr7WBHDWMC6IM1IfZGp0nu0qO6YrFzIXXFgs8sONTsclSzqJuCPPDUwtYjTxywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569396; c=relaxed/simple;
	bh=keS+9VAgswQL9uWFPhJ9o0XZitaJLafNE786v96JtUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gW0cIucdT8VXGkpfG/3lVIPWop/VnPAn9vlGt4clX6ZL3Ekx72cHfq2MeMrpar1+0noNn7BlsdnzrhW6Ya07ruM2JOqQ3+5Mmgk5JCygtswr5ft10D5UCi+h2TRv6KGQL+VkfWFHLm+etmRTn0urw6on/ZWGieRhcEUda8Eulto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5HWjmoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 672D8C433C7;
	Wed, 27 Mar 2024 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711569395;
	bh=keS+9VAgswQL9uWFPhJ9o0XZitaJLafNE786v96JtUQ=;
	h=Subject:From:Date:To:From;
	b=A5HWjmoPCMiwmqZAGxl5xTkOxxyxec2Bl6qYmoYeiRNmq/3TpIqz69xj2nZ2W/taj
	 1L60gnXYe7VF10Ed4oY0RVOeVCAfNaKQNMQd0w6sz3R9Cxu8XF1u5KPfSXK3MgCgFr
	 UzvgEWQAInWgEgZWRGlVnn2C6uXY33DpzlHyXVFEwTL+m4qP/pVVYIveS+mlbl4pXN
	 +5zYFvXWEHiuwy7pz38YuqZ5MeOO1i8j6ybio7Xzebt33SQFy++rG/T9FwffBLMSVF
	 C+h/1y3TaS7wdrRsZ4TTh7gSg/REa2+BNi7ezSXXaBrzfAz9NfSzllWm04b2SOoAXk
	 RtZO6CG8iMLWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DE1BD2D0EB;
	Wed, 27 Mar 2024 19:56:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171156939538.23603.13024373036387510121.git-patchwork-housekeeping@kernel.org>
Date: Wed, 27 Mar 2024 19:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h (2024-03-27T19:29:20)
  Superseding: [v1] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h (2024-03-26T18:07:52):
    [v1,01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
    [v1,02/10] spi: pxa2xx: Keep PXA*_SSP types together
    [v1,03/10] spi: pxa2xx: Switch to use dev_err_probe()
    [v1,04/10] spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
    [v1,05/10] spi: pxa2xx: Skip SSP initialization if it's done elsewhere
    [v1,06/10] spi: pxa2xx: Allow number of chip select pins to be read from property
    [v1,07/10] spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
    [v1,08/10] spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
    [v1,09/10] spi: pxa2xx: Remove outdated documentation
    [v1,10/10] spi: pxa2xx: Don't use "proxy" headers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


