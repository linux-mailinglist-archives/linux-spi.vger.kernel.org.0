Return-Path: <linux-spi+bounces-1890-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC71287F007
	for <lists+linux-spi@lfdr.de>; Mon, 18 Mar 2024 19:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01755B211EB
	for <lists+linux-spi@lfdr.de>; Mon, 18 Mar 2024 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C07055C1E;
	Mon, 18 Mar 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2o5YISY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68B55784
	for <linux-spi@vger.kernel.org>; Mon, 18 Mar 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788180; cv=none; b=OOGaBniA/BXC/xlmRQTWrNP+76pzjJ/Hs10gnTRUVHpgCeojQDkDOEeEsaJTF7/IxvZTJXhSo4qzYhM8ogG6UwB8flHVRWxZBSwS4peFKsQd8r1pK2JilBgFLk2rPi3m24AssGofgXsXiQL4m2mkuWCEPf98gbmbtVoKpULVExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788180; c=relaxed/simple;
	bh=/Qc9d5KLrp4YdZvhWb2JxP/6FRqKmbIX2KMEsvC3Tvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iNKxGOss5PTer+PXpd9/qBBnkaRH9BeZ0QcqHcXcT7D2Eys5cRQYSsMxBfLVXDfM3Cu2WEl+z42fRxK/0FZZjl65DIDnl+qfnnM1ozTpQiI/+mb+KxpcUM8rCoj0mshlxOImullLN+r7xoWGFDUKIzVOOfkAOwFkKViKE/aFFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2o5YISY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDDF9C433F1;
	Mon, 18 Mar 2024 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710788179;
	bh=/Qc9d5KLrp4YdZvhWb2JxP/6FRqKmbIX2KMEsvC3Tvg=;
	h=Subject:From:Date:To:From;
	b=M2o5YISY+MDBnQclUCxbxVkymDQxmaYY8ZsO/0231/QfLU6D8FKg0ff3IwIjk4LMn
	 a0Sc2/vHpubndA/CMJ3phlaYJP2ANOBL/E3qyHBFJerL2mGCoUhEeG7bdUFOwJ2uFR
	 kkgwHhhbvFABL5Sv2hCG9RcJuBdoc+pt41ZRu/HCSHM71t3hqMiK3eLKnYzZ84ZUNl
	 sZD/bl8+b2M6XmCu6vZCJSmWKSTfegpdIzKnzEixrBuCQVF8ciVXbtRnHE0rLjiYyt
	 gy6y7JRTWg0y8yS9Nol2YqeKG+3exVKLZ6njeoQohmhkqA7BPSUmYn0P7FYpx/1XGl
	 pnHx6oUv8IMsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAF0317B6474;
	Mon, 18 Mar 2024 18:56:19 +0000 (UTC)
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
 <171078817969.32290.2927626771148584141.git-patchwork-housekeeping@kernel.org>
Date: Mon, 18 Mar 2024 18:56:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length (2024-03-18T17:50:52)
  Superseding: [v2] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length (2024-03-13T20:58:19):
    [v2] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


