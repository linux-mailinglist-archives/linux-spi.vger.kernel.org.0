Return-Path: <linux-spi+bounces-5542-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96D49B5E4D
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AD01C21459
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52591E0DD2;
	Wed, 30 Oct 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBjbboOH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08221D6194
	for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278596; cv=none; b=pjAxNzf+8MmH3HASBpcxnzGwJMgoQlRpQZehkZKJ+JTqvTlao4Kq6NhV1mt6vxBSL6igSPeeYiAAEgGKt7/I+iLp8+ftvKu0trzLVoIshYKFp21UWpBnWtQGtLUD4ihH9fFYlrKado+cWmBShE/RkAIhuY6nr/9X1GiZaC/djwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278596; c=relaxed/simple;
	bh=njXV8EPnRY1XilZL9uwDaobI/B/2l5twWAPI5Y++y/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YA3F6bqdx8H1QdpG6dtzbzLgB46FbPJQU+/1Qux2+AktBoMDLjVuM2BLFXAi5DEaNnbYb4VI0xDuQmjAPtVGlENLH0WwZSmtpJuM0YPxpncszJ04ipH+4Tt+SqFEp65PPV7TuOjOOr6+KcEg8iCIBl1fpXFToLmhORWxu16udgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBjbboOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57706C4CEE4;
	Wed, 30 Oct 2024 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730278596;
	bh=njXV8EPnRY1XilZL9uwDaobI/B/2l5twWAPI5Y++y/g=;
	h=Subject:From:Date:To:From;
	b=ZBjbboOHgRzswr6fKkk9b8orUlYeDbq0oji/+1ISIf2slavMx/tqNLDV/CK+Qht3d
	 Msxv0nuhCLhgWVkbFTmPtfdabYarYrjY2hQdHk3hCb25DL/4g7bPJezcVXjNfynl46
	 wCO3kwKuz0M3oG5VtV90BZ73CTKsEPPhakYS9UTWvTNXrFyJHs9NDefollT8SyqEVx
	 1j2i0VtwiDguIkO3zwKFtDIN2Kn/m5KEuHkmZxJSYHEfJygX9qU5remf2eO5dXBgK8
	 3dnnt1Iftms9Hg6uqNONqaHFCx8RwSTmiAPM+jhljjBRkyjNzG4pdRN4ilDMIM2tWi
	 GBjeAH1zSwbgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ECC380AC01;
	Wed, 30 Oct 2024 08:56:45 +0000 (UTC)
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
 <173027860377.964132.2553067631417943587.git-patchwork-housekeeping@kernel.org>
Date: Wed, 30 Oct 2024 08:56:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families (2024-10-30T08:44:46)
  Superseding: [v1] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families (2024-10-29T12:58:44):
    spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


