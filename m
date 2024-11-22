Return-Path: <linux-spi+bounces-5803-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C179D6241
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 17:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6D0B24B65
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DC61DEFFD;
	Fri, 22 Nov 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="uYNlL+4z"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B446F30C;
	Fri, 22 Nov 2024 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292784; cv=none; b=BqSHKsHp9X7GieoCgmUdLUt5UZM7vKxGXhgFcPG9L4nMTikMHj5A2MACq0epFqfl+ma56qlsq9KemTHH72cFUGND4xnFVPD1uuTOJvESRnqjKOypcWAfrUu9tZ0LU+qp+Xy96Y3iygBFG89QS8hrAQfqJBZLGZb/uMiB/tYcS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292784; c=relaxed/simple;
	bh=44+y8ZYIXN3mzZSk4PSxgdEodrC0tL75rK3ncEunL8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N1yrsIqHEoNvUu/Th9Ngn1B0X1CXj7ooKyUBa4xYLWoZn8bpDXsyjEJu7+YkPheWUBbGP7F1Zsc+vS6/zs53rVs3sU5++cOm9Toq9UM8VQ0UfxD41yzSGK5QV5QLpz9E8z3FKVEJIrXlHdVqcL8Ear6Tb5BRuucyYlCOJ4+SI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=uYNlL+4z; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 070C7A048D;
	Fri, 22 Nov 2024 17:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=DgmMtx8fj816a/GURnFa
	t6+G6RLlkVLmq0pwMu2JauI=; b=uYNlL+4zIM+zX/JiygGWkVt1kpItmI5Jz3AR
	JvNEaPKACe/nP5lc9XyrHp1Cyz+QI1LHt8SLtKNTLHxc+lM1L+cw6TFmNjdKW+h3
	Qdvv0YzH9suP6fLlgLdFu+Gy+RQKynj4kxujfaTgeWYaVgC0tqxbcY30hkQan4Iv
	Cc4mfvwQatftfG4t3kMnnf0OMNF9Fca76R5Oax0AH9RMxunmFYo6Zt+A9NNuGXif
	cZFqxqQR3UmXLA9QT3Nnis9Q2CX3j74c1UvaKwyFnZi1UHGx4Zsi72GOFt4XgLAE
	siqeeNjBCf+vwy6pNtKuyssXyzmayo9Its+CLF5mKByod+sad+QyRbkm2OlISBV6
	NK25wQQrjt14EcasyNAnt6tKx0GKAEJ/GQzqpj+WDf1RVpwnPUPr6k0Pz4IMBhyf
	RAFKHxaTMckqz7v7OpmEITxwtWg2UNe0cnp+iYd9kke2TvxHyaslsoAWsbzOOvXH
	ZKvl1RrIhpFyHkVCiVv8lp2wx093tQ7AocH3ipJhfIYUqrHW/PGnjAgvh/GpRE0T
	K1jegw2QA3EL9rwcCo1cQkXrwLGHG0A3CApa/SE9B2gFbb4MKaX9s1/nrv/Wo5oN
	YBFDZwLrv40Dlc6ujWUeCwjNHA+g25bBHykYAL7sSVZpasTXGihBajlHQrte2jXv
	saqQcx8=
Message-ID: <5bd6dc85-29db-4f57-8d8b-156ebc116d03@prolan.hu>
Date: Fri, 22 Nov 2024 17:26:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel-quadspi: Fix register name in verbose logging
 function
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
References: <20241122141302.2599636-1-csokas.bence@prolan.hu>
 <a326f5ab-f36a-4210-83ff-0f2ae9fa830d@tuxon.dev>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <a326f5ab-f36a-4210-83ff-0f2ae9fa830d@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855607263

On 2024. 11. 22. 15:52, Claudiu Beznea wrote:
> 
> 
> On 22.11.2024 16:13, Csókás, Bence wrote:
>> `atmel_qspi_reg_name()` is used for pretty-printing register offsets
>> for verbose logging of register accesses. However, due to a typo
>> (likely a copy-paste error), QSPI_RD's offset prnts as "MR", the
> 
> s/prnts/prints ?

A typo in a commit msg fixing a typo, how ironic... I guess I should a) 
re-read my mail more carefully, and b) get my keyboard checked... It 
starts missing letters when I quick-type :/

Anyways, if you pick this up, feel free to amend. If there's a v2 (I 
doubt it'll be needed though), then I'll amend this as well obviously.
Bence

P.S. it missed an 'n' again, while composing this one. Ugh.


