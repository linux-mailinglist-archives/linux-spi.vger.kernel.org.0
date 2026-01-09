Return-Path: <linux-spi+bounces-12270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7393D0BBDC
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C5A03014DBE
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F1500955;
	Fri,  9 Jan 2026 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MSq+z6lZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE929405;
	Fri,  9 Jan 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980447; cv=none; b=TDP0rxj7YPKgnWkeJn0z+2xEL8Kw+NN7sw0k3fRICYHC8tIcLM5kBOErpMmQAmKmzYwzmZfYtvr+SgqJjRspaEbLD5gvMTJdTq7zutPkNh+3DNavYwGWF/ofr+wco97fRgotqgwyLHve+wvjVR/m2QRy/1eDuJOzsdL94jvgfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980447; c=relaxed/simple;
	bh=t1k65dqgJ6s3S41scUsPIB4jIsXICxKLu1hySpks8qk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XP6vlf3XVi5Ig48i0VeIBmC4rZfWd4hiDFGvroizh/hUw6tPWMJlJiR5K4SkU8QPMSRPCGr/MGEyh7xLUesq/qA2ztZS47sZLwFQIv/MzpX+dI5LY4pSqxV2eekGtzg4idcZY5evBdUK1H8dKSWWVzFsgGS/xpXEuDnI/DKp+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MSq+z6lZ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767980424; x=1768585224; i=markus.elfring@web.de;
	bh=t1k65dqgJ6s3S41scUsPIB4jIsXICxKLu1hySpks8qk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MSq+z6lZmQ2dFgSZe6uc8OrXpo3yjm5P8h0AN5cY/M3WhzWbycvu5bAI1eYDMoeH
	 cdNZKpWww/NluKvhqL22rhlaqAvLnmbqn7CBToztwpikMda+xIbh4tcHDXoAG+LYf
	 RzV06FFObZyhHLMVD7y/X/ms0tPgrpb2WcdupR9OFoxGFT6lP/oKJeVj1E9o9WtXJ
	 VyC2dbP9D/GKPbjpuZAIozlVrMjw5BcIkxO6Moog5Z4dZAYGeTbvyCaugLcMJtnlD
	 XrNIoOCUcjskCr+KSZTPXA3RoNCyN9GUqgUz/NV/S4TUfcvzdU6YY0Crb8VMCLI7A
	 RivIGIszP1Gz+Pg4+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.182]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmhjw-1w6PhG0H9q-00Zh4w; Fri, 09
 Jan 2026 18:40:24 +0100
Message-ID: <cfd8ce35-8aa9-4e9d-bbc2-9c87113e8156@web.de>
Date: Fri, 9 Jan 2026 18:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <gu_0233@qq.com>, linux-spi@vger.kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <tencent_AC7D389CE7E24318445E226F7CDCCC2F0D07@qq.com>
Subject: Re: [PATCH v2] spi: spi-sprd-adi: Fix double free in probe error path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_AC7D389CE7E24318445E226F7CDCCC2F0D07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:22o+883xXcAQIklX/pg77OTpgZ3eNEkv2jk5/nC8VUQ6CDC90No
 8ZhBGLWDKERnFvpYByrM3fOgtaymRVbGXMScpN+L7woZk1RN67Zd7wGa6kwVJ0ha5KGqYMs
 u8n078KpqopeRZWKAep/B3lhk+8QXFJCJ61I5cglzPq62PdvOujrK2SahYzuMU042mFNM1/
 7H2czfIUzPCpfQ+MQFJqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zDE+7P7g3DM=;ISIrAzBevZYyfEZntxcBTXgioTf
 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

> Fixes: ac17750 ("spi: sprd: Add the support of restarting the system")

Please choose a longer hash.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc4#n145

Regards,
Markus

