Return-Path: <linux-spi+bounces-2771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7608BF6A4
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B25D1C21166
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 06:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D79C147;
	Wed,  8 May 2024 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ1vRH95"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233C1A2C15
	for <linux-spi@vger.kernel.org>; Wed,  8 May 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715151387; cv=none; b=j9HGDlkiHKVWeAHWn9Ah/2RJFXrC/dMB/FmgveFDrSkcEEpxePV84WMDTloQqXWZfv92aV6xLJ7S38ATSXT7hv3vO01q71/p3T5W00kh6HTu2Hc75qHG4OKjAMFWNHwzwQ3P4XtlcsHd7DgljnPeY9/Xe6znds57mx2ECvA+glo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715151387; c=relaxed/simple;
	bh=V/53syd/pEjJiRM47qIY5KEoJN0ckNER69SapX2TwUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pNAipQIBdRDu1Zbs/iJlHH8fcA76A+lePtroj3u0HsksWTntKrEdDV8nHRBE72hytwQdKPEe1vDEvRx3IeJhmU0OlKOU3xjdCKfUE4XIVoeC0nQYwrQSR7xuu10lCVArPdluUKFSvJhfVDYJmMMrAabO4s9BmqDF1b/GUSgxz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ1vRH95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC307C113CC;
	Wed,  8 May 2024 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715151386;
	bh=V/53syd/pEjJiRM47qIY5KEoJN0ckNER69SapX2TwUw=;
	h=Subject:From:Date:To:From;
	b=GJ1vRH95vZE2G6V2oZJ8M/8MHnLoAnm6nqceHAL4nzIDelKjUXKcQ3B86cthcb0oI
	 WqNx+XHICN4lwRBBuIeIRXpr/6Z+UNUdaY6uAc93iVff9Wyl7b5R1+6xSni6Wh5Urg
	 AzRNiNXtRcWeXWfUWhTH7jBlwupGPAB1/O4JjHZ4CsuSpxTdFQmnxv/vt/QlrmXHCk
	 YL3gpycQXZrQUKoCiLMnVxRpq7N7AOkH1YZKWpPbuRccxcFsZUBw/yi8MnAH4mFLSw
	 mRA4sI2CeFWgKu71RTwsT7iQ74VrtTvdoB2Dv/bCLdjg2MzRkPKQtwP4ilUvPiMhyW
	 9eBX17uTk6+Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A85D7C43617;
	Wed,  8 May 2024 06:56:26 +0000 (UTC)
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
 <171515138668.18670.5698488083744456850.git-patchwork-housekeeping@kernel.org>
Date: Wed, 08 May 2024 06:56:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add optional reset control for Cadence SPI (2024-05-08T05:47:28)
  Superseding: [v2] Add optional reset control for Cadence SPI (2024-05-02T10:48:00):
    [v2,1/2] spi: spi-cadence: Add optional reset control support
    [v2,2/2] dt-bindings: spi: spi-cadence: Add optional reset control


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


