Return-Path: <linux-spi+bounces-10864-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCCEC1292B
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 02:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC5B1AA0A2B
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 01:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952E24169F;
	Tue, 28 Oct 2025 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="kGlVSUEO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DCD271;
	Tue, 28 Oct 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615643; cv=none; b=Rv5QyE8OW6I8VbR6kcgmsUG9LaMGAhg7upF12n+N357lBwQpF86EQkAszORpRqVbXoP8gvytblyqSITdGLGFcKHXVn9DR73Ga9i9SwA4lZnTgllk2w7P0tWTTv973pPeOiZPZz1KhTKfTJ53kM3d4njBXBEXQ06AzGIBBjdq51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615643; c=relaxed/simple;
	bh=EcrCH7gbIe4tGzJmOJrNzXrhbMMcFGwWbnUNw4n4WrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD5EZMc6pEtx3T/l/TWp6+BKHukLV+rfwADN4JFeUIwc/wGvPNNpbV08HDiCCNIjMP5kO1zhMjoAr/k2hDZdS8shlehmCHVKkexjPvPGyIFnj6kJ3tmTTWuMwcmjCFWRmXz69gGYStTAMeg2Cz/UWrGGZaM/auYylOEmB2dBG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=kGlVSUEO; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761615638;
	bh=+mEBbpFiHX0B6MrOl3zAV3KNKguB1G+AXghB9W8we/8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=kGlVSUEOrGkDFXHO5ca/aZBuFV2DoicFq7oU2X3RM3HVJmtaqI0SOj8DsibtNBrEZ
	 /0loprYQvfoqKUZFAtsYVsCto5r5hqoEcWVOjVsVvmbkyCoQ58fwWlm/Z2njdFchfW
	 iOCBNSosCSu+Y0cGcD0I9HzQMcKhoVcf61PQCjMs=
X-QQ-mid: zesmtpgz5t1761615636t467ae7ec
X-QQ-Originating-IP: SsILZdTTgN0uFTzov6mmR6/vmW89qEWwT3QwJkaNYT8=
Received: from = ( [183.48.246.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 09:40:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2958071386083091418
EX-QQ-RecipientCnt: 13
Date: Tue, 28 Oct 2025 09:40:34 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Alex Elder <elder@riscstar.com>, broonie@kernel.org, dlan@gentoo.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Message-ID: <3B5AA5AFF5C53D64+aQAfEn1OBGmevjfS@kernel.org>
References: <20251027125504.297033-1-elder@riscstar.com>
 <20251027125504.297033-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027125504.297033-2-elder@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NXAwOXNh0CeGXTtMbsPtTY68WXeBCbBNXWbUhmpTJn8PwfWHNPh1M/Bp
	D1hY8p7ytz+Q/Y8Nb5CV2TJbih7o76w3pV/Jb/68/EZUUyaUhauvjKqnWP5vzbg8t0RZL26
	ctHYAjkZQlrOCJHMQrreQcDke5/qoImaGXbsRAkS5v2Fhibj9VVeF7svQZ3cdy5r/75c1Ev
	2zqcX4yJfagg3yEHIfGjcrLcFUdMsn57fMPK+YfV9UgvXXLD2unUWUMo/mialTP3ilhnj/X
	oYV3CywRRXBsLLkN5iyDoz9Sm6jpdZirfpZ1H1zT9viUwMgv+LpgwanMC0sIr6XBFYpgqkP
	xCw92d33yGYqogmRZb3ld7t2UlKXSDFZ/kuyP0PE/STBkWn4b6IpiuCPbVn1VvGuTHjghRV
	HxRp9F7N292M6il6jMcKxJVHcTNnxnMswb4xsiG3PSy5AGa0MRv+tOxm5O0aLSiPhm/zP46
	hE5M43f/sugcJEtYzqXjI0Kc9qJYtgvpDOPIldjKIgEw6OJDWWG/BLmua5S+QWnpnxGDV8g
	n0EqNxn4rrlw3DZ47sYCC0ZFbOVln/gnX5fMsHFHxXzo6JXxQcyvLjaUHin9SU/5fspLiVQ
	n8wZhipSbYODPtRJLKzr1c+tAoc1W4gpyeCzVnOastz2hwWFS9rCScuSEyEGQ+hDyZj/cWw
	tYtP7Ln3GDxyXD8e+cmOXyGKEb8yjJS63kAB/xcLm4HAV893mMWMc8e46oY6gPCci6xmk5/
	Lp7uZis9MjWJNxTumouNePuaYPsMGXu3P6RJANxfqe32LDLa4xuviT8md+3vmWsK9NM1OJN
	04nC25/Gf5DSm38fS1sZ+Qsv0CqjJDr/aGdQipYKOOtbMD+fy+L58Ccvz02OghBfCuSWHEd
	XS8+lHkq3xWTCumpvq61uJzWr8H4Ofd9UPTdtKnvcz1iEomArHE+N2eCRNTcJ6u4qs1yhnq
	jlhZR7T3FyfJFtQbNAlHpuhZcyFTz7I/q7xVJCz9Gl2GygJ94Vvi2bD3/uG3ZPKqdr9Daaw
	OH/C3qlbanC0036MLtNGZl3/c77Zg0eOzkzlOZKQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Mon, Oct 27, 2025 at 07:55:01AM -0500, Alex Elder wrote:
> Add support for the SPI controller implemented by the SpacemiT K1 SoC.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

