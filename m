Return-Path: <linux-spi+bounces-2429-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7C8A97F9
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 12:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A295C1F217F6
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03EC15DBA0;
	Thu, 18 Apr 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb3mFL4P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFC15D5D6
	for <linux-spi@vger.kernel.org>; Thu, 18 Apr 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437786; cv=none; b=OIHMKKH90RHjmj/C7TeGIKmlcBcY0eSghaHwjC8TJWP/eJIYbi7SdVn9oa4VA0MaFglVCHdj3z+xRyh8vURtHYkYTcjM12usuH7Txlu/FiZWzWtI7cFKiM35zlO0f3IYjKUxgw93owHNAO2PQ9ZYL4FjjAcWPC9hqPJ37YZxmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437786; c=relaxed/simple;
	bh=vP9aZuJAzNBteWCVGDJNWbotTmR0uNXBmSSHburGuLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=l+lIzyxJW422dSlvYA9e0DT8E+D1PmMePTNeqpAo93WD1NbgO0FAu0jhg4haxV8RGCawe6Fvpzigta1uxhSpaCAkrJ/SgTJzxHLtvwX9tbFJqUjX8OU/M4LG6eYVtDw1Ed0kRun0XwdUqA5Fqw0IhQNYCj27SqU1+guRffQNLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb3mFL4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F37EC113CC;
	Thu, 18 Apr 2024 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713437786;
	bh=vP9aZuJAzNBteWCVGDJNWbotTmR0uNXBmSSHburGuLk=;
	h=Subject:From:Date:To:From;
	b=fb3mFL4PIVOtNRcOljgaizGT+oBRs2A4ZSYkDIatN2R2e3+xuQwvYTyh1awwefMNM
	 dIjNcC4yZaBEZdC6CBuvzk/+wcJJACZDHl7EElPNwzqntyWeoaN/+F1DpjBWvRdkkJ
	 UepIufeu8KZUF/zkOTV7DBuerXh+Z5g4JKUcGZndsuv/52p3Qr6cDnFoi+S0KjlMM9
	 nSUn4pWbd28GpIPh313CQQq5FrHan2/McjJrhIF10RPsr6h2gSeXmtBo+w3Lw36czb
	 ejmaf9lysisuG6cSPhfqkHeT8lg8zgcMJX2a8wV1wQXAc4UtVbTpVmV5KQ1uoH9iD5
	 59Jvjrv3rj0Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47716C43616;
	Thu, 18 Apr 2024 10:56:26 +0000 (UTC)
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
 <171343778628.10465.15353879842251693708.git-patchwork-housekeeping@kernel.org>
Date: Thu, 18 Apr 2024 10:56:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cs42l43: Correct name of ACPI property (2024-04-18T10:33:15)
  Superseding: [v1] spi: cs42l43: Correct name of ACPI property (2024-04-18T09:42:06):
    spi: cs42l43: Correct name of ACPI property


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


