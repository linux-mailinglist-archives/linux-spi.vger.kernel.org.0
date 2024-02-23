Return-Path: <linux-spi+bounces-1483-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF8860EC0
	for <lists+linux-spi@lfdr.de>; Fri, 23 Feb 2024 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EF6284AD3
	for <lists+linux-spi@lfdr.de>; Fri, 23 Feb 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FCE5C8FB;
	Fri, 23 Feb 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNztCGLy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C613D5C8E2
	for <linux-spi@vger.kernel.org>; Fri, 23 Feb 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682179; cv=none; b=Us50eF6HPWtcft/UgdtT2aQOvMf1jZ06SkXQQo1qO5EmvWjEnNlB2oEume2lcNJjNoiArC+2JjpfRoZ5GFPICgIRjNiW299U+4h2Ik2rexsmmK7XqXXSl+YSWa0+pa0K+AmGPqHur1JHPt+wr6Gw+GFN11L0B8seLNbVjcHdVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682179; c=relaxed/simple;
	bh=zQQiIH7gIbJN5oNqKp92ZNItiR4n5p9BNDmeRvexlvw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mP9ClephyTK8dwZJfyNzaskT39m/JInOz1XOPKw0lhcE58Dx0HbDTUg/W7icZijsh829mw+0So7GPbman1hvd3H+ATxea2E5C504aCy6WN8ik9y5vl7HbATluxiYiFgoqtVfavSQud4BqhYvIVrnWxJFX1Gt2jQP4RGH1Bg+CqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNztCGLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 443F4C433C7;
	Fri, 23 Feb 2024 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708682179;
	bh=zQQiIH7gIbJN5oNqKp92ZNItiR4n5p9BNDmeRvexlvw=;
	h=Subject:From:Date:To:From;
	b=KNztCGLybp3fGmlRUNTy2s/yGp78oQE64gxu1NlmIrVJZGx3YhD+2ZEE4iDhio+Yz
	 yk2t2lJOlfxyiqkB9vs32oJZsb5Op/wLSoXf2KO14k9peuuIV2N1qdDDAh8wkOkoh6
	 yX37o0LUC4WnXaV2yz+sseWBL4vOFHOtv5gPz53rDI3/aUQm2uYwcL0i/EIfBpaCG1
	 Lqqm3bDSxhsx1WMncAzorAD8vhvIyRmKs7bpzgQTyrqRdwLvpCr65IFE4pJ7QNdxtn
	 PdOZVUZ+3+KXMEePD536GIuenQ+JmDe8/E8GDtVGaGQ/YJucqEQSXSlPNi0ChYcbQY
	 eDGnXI+soC1AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AF4AD990CB;
	Fri, 23 Feb 2024 09:56:19 +0000 (UTC)
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
 <170868217917.14253.9995135710917497201.git-patchwork-housekeeping@kernel.org>
Date: Fri, 23 Feb 2024 09:56:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add multi mode support for omap-mcspi (2024-02-23T09:32:10)
  Superseding: [v1] Add multi mode support for omap-mcspi (2024-02-06T10:00:50):
    [1/2] Revert "spi: spi-omap2-mcspi.c: Toggle CS after each word"
    [2/2] spi: omap2-mcspi: Add support for MULTI-mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


