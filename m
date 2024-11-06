Return-Path: <linux-spi+bounces-5636-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F78C9BE16D
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 09:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DEA1C209CF
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7B1D966B;
	Wed,  6 Nov 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJZnSI4H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5161D966A
	for <linux-spi@vger.kernel.org>; Wed,  6 Nov 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883384; cv=none; b=aoxaKy8ZSN+nWkhIdZLoHe3K1Mn3mND2KyRzXxpcuRZQoKWkHmoitGa8JvND06BkKqftsuI7Soz6iEli/svFMGpvb3bvhhU5tcSo9w1gH+z/vsRi5BKHP+DsZ9fetMmE2zfKTnPvfR+RNeqJT1eegOfDbS19SMH9UjIX41F72WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883384; c=relaxed/simple;
	bh=ETmYRB/MQWJKmNoM+FAb3PmYigzZgrkGMb034QEXGZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PYv0pm0ADdkgSBLPdehmWSKtJNBY9W7R4VjlwdDlWCt13olv6nXd+92iOMfpEe4IqvQohqvDdrAaw+nty1q3eXJW6XjH2qby40ENfkVPxJJLvlZ8PEAov0doDyYhb0NwjHZC1nGLa6Vl2OUnGjIGucm3DGwFbqbT6KKZiVr3QIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJZnSI4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA92C4CECD;
	Wed,  6 Nov 2024 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730883384;
	bh=ETmYRB/MQWJKmNoM+FAb3PmYigzZgrkGMb034QEXGZ0=;
	h=Subject:From:Date:To:From;
	b=QJZnSI4HY34t2pFxTDuDOuauxyBxpt4JCFHrw7oGhN1w6zQxLGoxiyebjDqNrNqy5
	 Iev5nHrbE5JDBQvIOHRb8FYIA+OQ+QZg4yZPqQ1p+Y/WC4ggZ8ZsbXq2+VAQfFemj2
	 evq16+gN5kp0bpz2710m7JF6AZIRGF8TQ+5vjhzbtsJhNwPkSAe7UHOIIjnUAd3yXL
	 CvQX/EM2Zg2excoB5SZFUUwnPtMO4Xby3zwprAY94GczHeL2jgWl+95uaXD0YWN8+j
	 WOQZ/9hHT+BTYr2WOMpKRHlA0RAsDFDGCv7NBdc4gLdbahTaWu0sM3J+Od87qSjL/F
	 wwyoENprQdO/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCC3809A80;
	Wed,  6 Nov 2024 08:56:34 +0000 (UTC)
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
 <173088339276.1158044.13599346408018504152.git-patchwork-housekeeping@kernel.org>
Date: Wed, 06 Nov 2024 08:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Apple SPI controller driver (2024-11-06T07:54:00)
  Superseding: [v4] Apple SPI controller driver (2024-11-05T08:08:28):
    [v4,1/3] dt-bindings: spi: apple,spi: Add binding for Apple SPI controllers
    [v4,2/3] spi: apple: Add driver for Apple SPI controller
    [v4,3/3] MAINTAINERS: Add apple-spi driver & binding files


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


