Return-Path: <linux-spi+bounces-1702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FE8755A1
	for <lists+linux-spi@lfdr.de>; Thu,  7 Mar 2024 18:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213D61F220C1
	for <lists+linux-spi@lfdr.de>; Thu,  7 Mar 2024 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C5130E44;
	Thu,  7 Mar 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBTP2JUk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B6130AC4
	for <linux-spi@vger.kernel.org>; Thu,  7 Mar 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834196; cv=none; b=kL7MaVoCLZfLBklRhqzvjtOhIZP+HyeBEde0qsNz+6/8tE2NLx0ApiwUjgijUqireIH+EZDNMvsxywp+WPZZTlYjgUNeaTA0uiHS1HQ8W5FE5VTcYYYfXe2yfUq92p7c1Pgy6FCeCRFWPc+h9nrBS4qyj+scMOnXFN5pfJInhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834196; c=relaxed/simple;
	bh=A+iGUJwZlO7ab/vDHHKkPPHVFH8/BLViysSSwtXMqRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mT0ndyVhJnOW+OvxFLomMUphgAJTKjXiLCYSfAjSqv3lwO0WjWpmq6EYACPwBgSiSTmK7subfWP52cFSosmsbePHfpIzRE6pLh5amDK9zUvi4oe/sNGkv147+7Wc6QTJ/fVCBdpapGNq5i7kenL07qStvUXlLWHiI22vpv6fHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBTP2JUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB6EC433F1;
	Thu,  7 Mar 2024 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709834195;
	bh=A+iGUJwZlO7ab/vDHHKkPPHVFH8/BLViysSSwtXMqRk=;
	h=Subject:From:Date:To:From;
	b=eBTP2JUk+tjheje7I4ud/Ae0LhQCXju7Y793jfejUw5Ytl/H9L31LB093pHbhlL7m
	 BSTVXe5LzJsTu+iHrUMGcEVTdayC8gYBVrQGV7hGx+mN1Jsdd8ZAapMKxpOrZ45q9a
	 eYpPvm5RE5ZGRpBxS+2So6oa5K85yW/ufGOyEfIUfRIGDrV2QgQX/Wye42YJ+zQ3Qa
	 hNe6qgrniG2hokzPxi79quZ6hQqUPf/Z986GBY8UMgJDzHTHwtxWyKeiLTRhe79sT1
	 dZ5UWG3tzwSukWTl7/Byaf1oyUjXMF+hTecOLtyeFdoxf8l8mCQdGvfdmRL57xi1qQ
	 TGI8q98D8ZQnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 502D9C3274B;
	Thu,  7 Mar 2024 17:56:35 +0000 (UTC)
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
 <170983419532.821.17497139119129460823.git-patchwork-housekeeping@kernel.org>
Date: Thu, 07 Mar 2024 17:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h (2024-03-07T17:03:15)
  Superseding: [v1] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h (2024-03-07T16:07:37):
    [v1,1/2] spi: pxa2xx: Kill pxa2xx_set_spi_info()
    [v1,2/2] spi: pxa2xx: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


