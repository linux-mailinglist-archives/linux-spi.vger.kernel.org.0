Return-Path: <linux-spi+bounces-4723-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA959710B0
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC98D281222
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 07:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81B1B3B3B;
	Mon,  9 Sep 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHvJj5ne"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74C1B3B33
	for <linux-spi@vger.kernel.org>; Mon,  9 Sep 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868622; cv=none; b=O/7VgFXV6AHeOIuCmk09TfVJzcHSVgUfK+Ari8J2n5QXbbrxSGsAx49+6LdJFRVrVq+VDAid/fHM/318VthTJDMThjG2GkFH+GrhXOXDAdQsrN+c5GMO69KVpnsXx+9KzPUGv/Soha+fSHwbkKXqlX6P/HQhK/6ozFJ08rvGMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868622; c=relaxed/simple;
	bh=UAITHnFNkRD4Zhm9hgSXyVcBUqv3hYjvG9qYyqHeY8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mkzR3B+BQB7lJCAkbH1FpfH1zqs9SOc3kE2od3loONzdvuXTzD566cPnzTsJWvpMdZ/HFgvxI0+/pY+uuidaafw1E6fvRY76/fL2YXZVBZatjDdoDKa3HDUFRyyZoHEeHa94egxRpXpfyPW8cpIzA2Hh2YtcJ6weLgWyolmSTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHvJj5ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D991C4CEC8;
	Mon,  9 Sep 2024 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725868622;
	bh=UAITHnFNkRD4Zhm9hgSXyVcBUqv3hYjvG9qYyqHeY8c=;
	h=Subject:From:Date:To:From;
	b=mHvJj5neuvu261ynPvrOsdUrshDGTN1qyjD48e489+fjB+dtz/qLksaPUZ+yCNsTB
	 0aHRialJO43pGaboMeeZSOVm5YFXE9G0ObyqyBG9fYzMSpY2bkztFkOMmRas7j18tL
	 /4HNrKoS/k+H3uo1srjPe56BH+tu2eH0dugk185sXCRVdGaH7hh7bM8bLyLVvuwg8m
	 yYQYXuQyayXvV98SsPQz5Y/NMGKKb31oJZZ1KknGViWc7KSbSDXdf16aviGwWUXcDH
	 BCgGDg+DM/L/8/5WeX2VsJPiqD2bavWDOqw3QSn+EgBKeRfyJK6uUkel2KWZhv3zeB
	 Wknnxw8FPJBqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D893804CAB;
	Mon,  9 Sep 2024 07:57:04 +0000 (UTC)
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
 <172586862276.3365499.13079799249117600584.git-patchwork-housekeeping@kernel.org>
Date: Mon, 09 Sep 2024 07:57:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: geni-qcom: Undo runtime PM changes at driver exit time (2024-09-09T07:31:38)
  Superseding: [v1] spi: geni-qcom: Undo runtime PM changes at driver exit time (2024-09-04T02:19:40):
    [-next,1/3] spi: geni-qcom: Use devm_request_irq() helper
    [-next,2/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
    [-next,3/3] spi: geni-qcom: Use devm_spi_register_controller()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


