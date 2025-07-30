Return-Path: <linux-spi+bounces-9232-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E587DB15F04
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 13:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E95660E4
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 11:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B272295D91;
	Wed, 30 Jul 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je6WD+PG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FF295DBE
	for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873168; cv=none; b=VgJqEQ15gJncaU3jBbqw1yKwE0xs9JsUF77FjcIK6J1a0FZSVtr2KII0gY5g7CDF41tvuJe8gkfaIzalbmJaJ8Al5gY6KXelQJwCVHuLT7v49ldASxhlhNSGwPtLX0cT+Cda86R+pRwPwkdRvqrCOyL4S8XiuB1L1NVORhrcAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873168; c=relaxed/simple;
	bh=aef/ycW/nvY/oApY25dECBgftMBfDPE3ixS4M0je0BQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=k5mOz52lz0NBCEy870mAN3s/RFbiKjizBQ6/TQKQ/z9LRlZb4vHX5B5bVnYEvid7V88GLfMcE6rAL3hySWenAEAk/Z36HT1vRQIPbvrGA6Y1jENBW8u4ijg3/lZH/D+iLG/63LkVF0MqKNVNuEINFIhjFAdNJWvqmA4fga2o5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je6WD+PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00215C4CEE7;
	Wed, 30 Jul 2025 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753873168;
	bh=aef/ycW/nvY/oApY25dECBgftMBfDPE3ixS4M0je0BQ=;
	h=Subject:From:Date:To:From;
	b=je6WD+PGyRErWTBC6L4og0m9K1QFrXCb/LIljky4w6JKZJKXEXe1VwCZXUoauvNUn
	 wb/dkzwtdmFUf9HwG20DDXmbjrB1+ztvE9dnnbnWdq+qmmNoUlcN5TrR3qonuPRMH0
	 ItOuKc55uXVc0cKdK58Y/lQf1HgBd/OkPx46SOLlgLMsT7G4IhoRdLJb2oto4OTMq6
	 DjKGIMirzXEWAese68Sfnun9qQ0V+5T9eVMJVUxgNO1sieHytsR9IyhcTHAHO7VC41
	 EpVaDFHoZqLFfWraRNIw8Qv0x4M679EG+f55mQUb5B/MGtqnndXbdBv8ocBBzmt3ay
	 7LwgIxegQIAFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D14383BF5F;
	Wed, 30 Jul 2025 10:59:45 +0000 (UTC)
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
 <175387318371.2252268.10129488186486078672.git-patchwork-housekeeping@kernel.org>
Date: Wed, 30 Jul 2025 10:59:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: atmel: simplify MR register update in cs_activate() (2025-07-30T10:10:13)
  Superseding: [v1] spi: atmel: simplify MR register update in cs_activate() (2025-07-30T05:35:59):
    [1/3] spi: atmel: simplify MR register update in cs_activate()
    [2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional 'spi_gclk' clock
    [3/3] spi: atmel: Add support for handling GCLK as a clock source


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


