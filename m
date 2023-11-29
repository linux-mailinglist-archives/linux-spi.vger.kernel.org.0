Return-Path: <linux-spi+bounces-100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750807FDDAF
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CFD1C208FF
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDCE39AE7;
	Wed, 29 Nov 2023 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRnUP5U9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A571DA24
	for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 16:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CD8EC433C8;
	Wed, 29 Nov 2023 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276985;
	bh=2JAjiXJRxpQXMSEHGX8DfFQoQkCWYJTk5i+O43Ge4/w=;
	h=Subject:From:Date:To:From;
	b=iRnUP5U9/IJK/1v/5Xis8eUnUjpc0NS3ag0QZBW2vxwk3EmiIWIfeBdshz0LqkrdQ
	 bfK7ypDOkmgd+8VO8mwb9+RofsSyHySYfOSt4sMITZO+QrBzxM1jFPx6Iijd48pO6X
	 Fny0POtVr7Ib52Nu/CFlJ1mrg2P/o2+82Iv2/2YF9KTRYTC8edEGS7E3hmRI361joy
	 C/KKxiZtFQFnOdOzFJp+QYM/GEbP/9G2WonKVZcLczxXbE02VnJlWKXj0PdTNB1J/8
	 JcTW4bFB2fBvwo/zpnXAR+4Xw5ZF3cMXcJriLE28+0kLlwIy4O2u4lV6iApriYircH
	 1FolBnZ67PR6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30A07DFAA82;
	Wed, 29 Nov 2023 16:56:25 +0000 (UTC)
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
 <170127698519.17330.10963322294534697214.git-patchwork-housekeeping@kernel.org>
Date: Wed, 29 Nov 2023 16:56:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spl022: fix sleeping in interrupt context (2023-11-29T16:31:54)
  Superseding: [v1] spi: spl022: fix sleeping in interrupt context (2023-11-29T13:32:17):
    [1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
    [2/2] spi: spl022: switch to use default spi_transfer_one_message()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


