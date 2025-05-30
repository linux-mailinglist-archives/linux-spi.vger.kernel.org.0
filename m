Return-Path: <linux-spi+bounces-8341-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941B7AC8C9A
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 13:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4281BA4FDD
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B8221F2D;
	Fri, 30 May 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLF12D8F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A422154A;
	Fri, 30 May 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603260; cv=none; b=nOoCmbln/uEk4Jj7PikGS6/iNYaNBYvvTkiYHEDJfalDjbuvD6rboAOGoZEVcZP0vmydKRBuoIpNQpsitciVXVNkakOXrsw5LopYrHpL91j2o8rW1SrAyCtTiQ+eR+v/uQ05ZGuLtKQTReEboilX8Afg29cBqcEk52rCrU1aPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603260; c=relaxed/simple;
	bh=FCW4DfUTseZWdlQKBXoT3iPxIReGVkSGs1EtU70fb9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXAVfSxZ2eDRFmH49xbKOALRyr7JNPHgEuQ2pdFq3aFz3PG8m4yjygT7kZenXLhu5ht01oX3eDu5dEjT1H8ytC8mvNHxhUANkDuY5eRLxBdjbw6rIJCsDouHjK8MKQ+HRUDD6HSm8AKj2D3CULRepHfBy2p2AtF7OEba7RshumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLF12D8F; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adb2bd27c7bso230235266b.2;
        Fri, 30 May 2025 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748603256; x=1749208056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4ZdmHPp5u88c677hlTmVdlU6RsFYWCDgNeLS1e4+ps=;
        b=lLF12D8FOyrmViMFcaGThomW+Ar9CrKDFVztYXskrGuosvQ+4jtpMv0r3oSJGGV+8g
         XSWYboDqJKNmBTbAO7jH4d/mKaJ6l/voIJ3GbWidlWfExIEgrV/7pttthVrRxFzONXmN
         tokRSgSAa5Snml79+Pc+m8TRanj4twior7o+yv3aER/ZsKE7mVYyQpq2Hm9CRSqhoNXj
         xM6pii6AhGAU6Txt4clF7722+FylaWPd8XNEZVtTQVrBc2Q0nhYvVybgNcEhPXt2WzuS
         5+XbbVgJrb1liRrYANv8T4AEYIy9m6iaGqUIwKHlQZo5tY3WP1ymF5UBYWcVz/jRx0I8
         J4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748603256; x=1749208056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4ZdmHPp5u88c677hlTmVdlU6RsFYWCDgNeLS1e4+ps=;
        b=bp3OWCQeie2+ChhlrHk0SXW205EuDTRaTwDZtBMgDimTaEiDiGA1UaTTJXlxWEMPgZ
         teC3lmZ8aryeYxE9aKEqfuoQmX3EPghlFl24oIRFuDwEaMT11nwF2+Ol7GLj3C9Vj88d
         rjsTYWieeNKZRAMJuktwNn8nTKj/pj4XDbjKI1LRopN7kyp5WrID62IlKbrYuSjtk2VJ
         evQXr04o+kuFseRoQCibhgOw/K5RMy+Bxvk3h92U8knMWOHk2AWKlci7CtQkjQ+KL0hF
         A1IQYyzKGaz/4Lb9wwkxqqU74emZfRUqQdRK9nq/LxktHapXliACU22GIyON/TEx6+pA
         6zhA==
X-Forwarded-Encrypted: i=1; AJvYcCUFDKwOXUlDfVadRkPIR+dsL18L34k9H4NdjfrDU/bQNbwPQc6UD+tELpU0HOdGa37ZvXF+/WJkbgmj6+nc@vger.kernel.org, AJvYcCXhw7HU+TRuBErxn29nIfAJKuzgoHqp5VJZ3xbeUmTRNO+RzSTIvV3uSq9L8InykQQSOcPPJBzHVOwlm4tx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2p30/4fe/bp2Uo9s75i5EVvEHReX2GdgEaM3oma3w/spDwXI
	beMr93udfGPanHFSo2cW94vsAPZMcTi7aicMFfTwJf7K3xc0AxTkmzNNiPNGRg==
X-Gm-Gg: ASbGncuyc8rAK0hO+F8uyQHkeJOHI01W58+vPOHEeTFYQ7aUo8FMj6QDRNDUvm8nYvY
	A6BZnQDv2gJODNX+Wj3SZJFCDFF4OtCq8ZDgY6PoTiSb/REN9mhDtYK+YrUwogfW0eF7DmFXS+f
	oVgyCLASxaivjYiz4Dbwal/DpSxwFGKOQBXKpI1TTE/zUBZfKXB7yP6yzDpuFYZRphZJCldn9Vp
	7WwwU61pmwjnpZTcdXR3lkWLaQMOUXYIE2rANpmvcHphoay0eFymhz7I4tUNl3hcgUfIhxodlbj
	pab+bkUxzECYXVrn1nQz1Oh3qw2LBZcv+dKrx9H0K88BA8aDdkKOfQHJWlolEmXVfkBULk5jqbT
	uMsC3+QBM9g7SdEPxMLYPaB+NJYE=
X-Google-Smtp-Source: AGHT+IEJEZ0HZGATsOA3e1o6i0DTK+hWUEQ2zJOHWGQcm9LQPtIAr5i0sQqhE620G4EgLJF6VkfVkg==
X-Received: by 2002:a17:907:3f09:b0:ad8:8d3c:8a73 with SMTP id a640c23a62f3a-adb3228d6aemr265848566b.17.1748603256265;
        Fri, 30 May 2025 04:07:36 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad3952esm306355166b.126.2025.05.30.04.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 04:07:35 -0700 (PDT)
Message-ID: <28db650d-a911-4df9-9ad4-f926ea0683e6@gmail.com>
Date: Fri, 30 May 2025 13:07:35 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mtd: nand: qpic_common: prevent out of bounds
 access of BAM arrays
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mark Brown <broonie@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lakshmi Sowjanya D <quic_laksd@quicinc.com>
References: <20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com>
 <KuueBg3qliXMt9QN9kV_5_on2xJV-BEWZAsktO_Ce-Fq1iBAPCFypbYUVZxlV4LjF0AUZG57KqiXZZ3uefQrXw==@protonmail.internalid>
 <20250529-qpic-snand-avoid-mem-corruption-v2-2-2f0d13afc7d2@gmail.com>
 <68c54d56-3e44-4f43-8bd6-f6b7fa1f379b@linaro.org>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <68c54d56-3e44-4f43-8bd6-f6b7fa1f379b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 05. 30. 10:56 keltezéssel, Bryan O'Donoghue írta:

...

> This one doesn't apply to -next

It is because the series is based on the SPI tree, and -next contains another
change for 'drivers/mtd/nand/qpic_common.c' which comes from the MTD tree.

It can be applied by specifying the 'M' switch for b4 shazam.


$ git reset --hard next-20250530
HEAD is now at 3a83b350b5be Add linux-next specific files for 20250530
$ b4 shazam -M 20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com
Grabbing thread from lore.kernel.org/all/20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 4 messages in the thread
Analyzing 12 code-review messages
Checking attestation on all messages, may take a moment...
---
  ? [PATCH v2 1/2] spi: spi-qpic-snand: reallocate BAM transactions
  ? [PATCH v2 2/2] mtd: nand: qpic_common: prevent out of bounds access of BAM arrays
  ---
  ? Signed: DKIM/gmail.com
---
Total patches: 2
---
 Base: using specified base-commit b00d6864a4c948529dc6ddd2df76bf175bf27c63
Magic: Preparing a sparse worktree
---
Applying: spi: spi-qpic-snand: reallocate BAM transactions
Applying: mtd: nand: qpic_common: prevent out of bounds access of BAM arrays
---
Fetching into FETCH_HEAD
Will exec: git merge --no-ff -F /home/juhosg/devel/linux-ipq95xx/.git/b4-cover --edit FETCH_HEAD --signoff
Press Enter to continue or Ctrl-C to abort
Auto-merging drivers/mtd/nand/qpic_common.c
Auto-merging drivers/spi/spi-qpic-snand.c
Auto-merging include/linux/mtd/nand-qpic-common.h
Merge made by the 'ort' strategy.
 drivers/mtd/nand/qpic_common.c       | 30 ++++++++++++++++++++++++++----
 drivers/spi/spi-qpic-snand.c         | 16 ++++++++++++++++
 include/linux/mtd/nand-qpic-common.h |  8 ++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)
$


