Return-Path: <linux-spi+bounces-7886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FCAA9445
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B3C3B2B8E
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDC91F4604;
	Mon,  5 May 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RduAWrjP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138F1A2C25;
	Mon,  5 May 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451318; cv=none; b=mcjV9ijbhDUypPEc44UqO66ZL595x51KTGdmGO1cRNRkHP13+0eenEvtcAWHm7uoybie9h8xWl/7HYR6k4xqSY1GHlMYS/UTEr0Vaqc7G8d0KX6xrLpWdT6kkUuvBaGuxK604If5rTT016oKkIrNZH74ugudy0z1YBq8+g7kc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451318; c=relaxed/simple;
	bh=xSAdAEEOiXr6TG/uI7Yd9ITl9T50e16u8CNKULKKrEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXVcbSBqfgx3o8lSl7nTvqcr/uNCJspjHGVHU+YPo7H9A38PtvZNGG75eXlpPvfPVDVcLkDUxE7i+Wx67m7oWBoQJRHTMh4uovMh8S5Kdtt+Cw3uJvsPFTVOAxgFKBZG+34/tzejBYGdGX2jN+AM5HeJq8wo5sCnGCqvBPSn78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RduAWrjP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac339f53df9so927433966b.1;
        Mon, 05 May 2025 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746451314; x=1747056114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/aTIIb8Wt9mHnUVaIv3WqxGzaHlKMrFSeU6LEqVxaw=;
        b=RduAWrjPcOS4sj9IxX4ZpnkAmrGDGqcSD7fxPjUkEQhru4BPFthrGMj1kTPsbYsa54
         PnKVlXFPXKPXwn8SKcJ2GrSR+hbe/57Fe2VkuJGI6xCSYB3t7gjdG+RtwCoO2/0IIoBQ
         36HsQRccL8u9wQ8ZVNIyVLrdCTj0blNunXrvo7rcvEkjtZwym2DUHKSJZkflun7P/838
         2djcsjLplaSne5gGcx5bgtN2crsLSoj7DUUnIGy47m5LE7OStFjdzBHFWRrGj6euMnjf
         NserOA4F1/jQNd5Hv9sh5HLx2+Wz9ImebK8eCpYc/+YS3jZq7jcxLFIaR9gxMNxjKCYr
         YWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746451314; x=1747056114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/aTIIb8Wt9mHnUVaIv3WqxGzaHlKMrFSeU6LEqVxaw=;
        b=UxU7/VdMZPHXnHrzmU/58HpL3HEibD9O18UIozd4WB2UQNzfW4/WSEweLKlvLij7qt
         c9lDKOYQU6NaQNuF502pa9IzkFDI3rXE4EYbvJG+pfj5bYzF8i7/Ro+aI+rkG20af8GE
         qb1galdCx+4gHQ2iZYgWEN74kiTKbglOizLwkvPUKDICS7xRcGbeJexTcVb5meP/x3cV
         NTsH0XciOLtf5GmI2ciNf4BTAjtnhQ40IB3s8BKUi6BVvKjNzVFW05Z93NENWKgrB0Mk
         8rAUndcg6KJWZomUIGs1ZkD75bSHmvvdS7Ko1B81COQkjuum6CEyvIJBEhOmo6utCq9F
         BQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUukGptQYT70CLv8cGXowafLbInwK1biDecJMHeMPTQPdvJWDFl5uFs2HpFk19ERFk7m+rQU8DEsjtXDerH@vger.kernel.org, AJvYcCVmXXF3sKGkgGGmyS1gUxeslDMnFHfXUKrF5LF+Ac7a3f2zlNj7Gr+nNP3j+77g99NhMB5WYhvUK7pA@vger.kernel.org, AJvYcCXYsxmUEZNUeQY7fjL3EjqtsiQcbVCSRbSQOHbY2Tl4NLrSG7uVN8vc6AZWhNW8XXnvTwuHRrY2vtf/W4bc@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYlLRvOmfv3QHkMxlhIiBErwyQn0VLmvIndKpBWeAsVlcdtma
	Qw9eSxO7905i5+zPcrOCJd1CXEOybrEhb9LEDdQZXocUApQLC+79
X-Gm-Gg: ASbGnctZ5x/m8gjqzgOG4klVPFttkUn7123tE2wS2v+XVvv2U5pFSAaRoJ94x3x4HLI
	WZnIDU4OGMV0Fp41YHpZvIRNILbrbzmVqqv0DQMReu6gYLYH/j5XO5ZLw9IJWikxAOmcKLOnl/p
	+wginD/tJcSUVASo7EFxfySb+lS54sY0Nv50rwdhY4lhc51B4CWTxqbjfH+l1eyGp+lBg5qdgcX
	f7taftdhqjEIe3MRk1Yph70YBIoLL06Min0m8rBHRO2IS1HYxyaOXBV6GtuyJzR1N7uoTrCiR0p
	qkY06/ZayRB3DZlT/Yi0FIHIoQofGcrO4vFQ9ZatU4i7jJaTkQM+1pENJWXHekERqTJMKmoV7kt
	dFdTmtQ==
X-Google-Smtp-Source: AGHT+IGr6/Er04ihWAiKCaSmmuGAWScKsAt5Ixq8keSch2sNLQcPFE8U/H8frEpg5MVGyiYg0RsHWA==
X-Received: by 2002:a17:907:7248:b0:ad1:76d2:d06 with SMTP id a640c23a62f3a-ad1a4b06c35mr624087366b.47.1746451313504;
        Mon, 05 May 2025 06:21:53 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a3c69sm494099266b.59.2025.05.05.06.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 06:21:53 -0700 (PDT)
Message-ID: <c1729d39-9f7f-4c6d-b8a4-72dfee4bfca5@gmail.com>
Date: Mon, 5 May 2025 15:21:52 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/2] spi: spi-qpic-snand: add support for 8 bits ECC
 strength
Content-Language: hu
To: Md Sadre Alam <quic_mdalam@quicinc.com>, Mark Brown <broonie@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
 <20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
 <8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 05. 05. 13:17 keltezéssel, Md Sadre Alam írta:
> 
> 

[...]

>>    [ 2720.344163] mtd_stresstest: 8192 operations done
>>    [ 2761.645640] mtd_stresstest: 9216 operations done
>>    [ 2791.760534] mtd_stresstest: finished, 10000 operations done
>>    [ 2791.760817] =================================================
>>    #
> Could you please run biterror test "mtd_nandbiterrs" with the same device, since
> you are adding 8-bit ECC support.

Sure, here is the result:

# insmod mtd_test
# for i in $(seq 0 4); do insmod mtd_nandbiterrs; done
[   45.405610]
[   45.405638] ==================================================
[   45.406164] mtd_nandbiterrs: MTD device: 0
[   45.411807] mtd_nandbiterrs: MTD device size 268435456, eraseblock=131072,
page=2048, oob=128
[   45.415990] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
[   45.424495] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[   45.434686] mtd_nandbiterrs: incremental biterrors test
[   45.436653] mtd_nandbiterrs: write_page
[   45.442634] mtd_nandbiterrs: rewrite page
[   45.446408] mtd_nandbiterrs: read_page
[   45.450346] mtd_nandbiterrs: verify_page
[   45.453320] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
[   45.457405] mtd_nandbiterrs: Inserted biterror @ 0/5
[   45.464431] mtd_nandbiterrs: rewrite page
[   45.470216] mtd_nandbiterrs: read_page
[   45.473852] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   45.476909] mtd_nandbiterrs: verify_page
[   45.483090] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
[   45.487098] mtd_nandbiterrs: Inserted biterror @ 0/2
[   45.494111] mtd_nandbiterrs: rewrite page
[   45.499850] mtd_nandbiterrs: read_page
[   45.503557] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   45.506597] mtd_nandbiterrs: verify_page
[   45.512777] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
[   45.516768] mtd_nandbiterrs: Inserted biterror @ 0/0
[   45.523810] mtd_nandbiterrs: rewrite page
[   45.529586] mtd_nandbiterrs: read_page
[   45.533224] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   45.536305] mtd_nandbiterrs: verify_page
[   45.542464] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
[   45.546457] mtd_nandbiterrs: Inserted biterror @ 1/7
[   45.553470] mtd_nandbiterrs: rewrite page
[   45.559244] mtd_nandbiterrs: read_page
[   45.562914] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   45.565991] mtd_nandbiterrs: verify_page
[   45.572153] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
[   45.576142] mtd_nandbiterrs: Inserted biterror @ 1/5
[   45.583158] mtd_nandbiterrs: rewrite page
[   45.588927] mtd_nandbiterrs: read_page
[   45.592599] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   45.595680] mtd_nandbiterrs: verify_page
[   45.601840] mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
[   45.605831] mtd_nandbiterrs: Inserted biterror @ 1/2
[   45.612846] mtd_nandbiterrs: rewrite page
[   45.618618] mtd_nandbiterrs: read_page
[   45.622286] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   45.625434] mtd_nandbiterrs: verify_page
[   45.631528] mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
[   45.635517] mtd_nandbiterrs: Inserted biterror @ 1/0
[   45.642533] mtd_nandbiterrs: rewrite page
[   45.648303] mtd_nandbiterrs: read_page
[   45.651975] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   45.655055] mtd_nandbiterrs: verify_page
[   45.661215] mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
[   45.665207] mtd_nandbiterrs: Inserted biterror @ 2/6
[   45.672221] mtd_nandbiterrs: rewrite page
[   45.677987] mtd_nandbiterrs: read_page
[   45.681663] mtd_nandbiterrs: Read reported 3 corrected bit errors
[   45.684741] mtd_nandbiterrs: verify_page
[   45.690902] mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
[   45.694892] mtd_nandbiterrs: Inserted biterror @ 2/5
[   45.701908] mtd_nandbiterrs: rewrite page
[   45.707678] mtd_nandbiterrs: read_page
[   45.711351] mtd_nandbiterrs: error: read failed at 0x0
[   45.714431] mtd_nandbiterrs: After 9 biterrors per subpage, read reported
error -74
[   45.722975] mtd_nandbiterrs: finished successfully.
[   45.727101] ==================================================
[   46.200485]
[   46.200512] ==================================================
[   46.201039] mtd_nandbiterrs: MTD device: 0
[   46.206751] mtd_nandbiterrs: MTD device size 268435456, eraseblock=131072,
page=2048, oob=128
[   46.210763] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
[   46.219377] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[   46.228941] mtd_nandbiterrs: incremental biterrors test
[   46.231522] mtd_nandbiterrs: write_page
[   46.237524] mtd_nandbiterrs: rewrite page
[   46.241199] mtd_nandbiterrs: read_page
[   46.245175] mtd_nandbiterrs: verify_page
[   46.248195] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
[   46.252254] mtd_nandbiterrs: Inserted biterror @ 0/5
[   46.259317] mtd_nandbiterrs: rewrite page
[   46.265230] mtd_nandbiterrs: read_page
[   46.268955] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   46.271784] mtd_nandbiterrs: verify_page
[   46.277987] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
[   46.281941] mtd_nandbiterrs: Inserted biterror @ 0/2
[   46.288985] mtd_nandbiterrs: rewrite page
[   46.294803] mtd_nandbiterrs: read_page
[   46.298414] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   46.301472] mtd_nandbiterrs: verify_page
[   46.307677] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
[   46.311629] mtd_nandbiterrs: Inserted biterror @ 0/0
[   46.318686] mtd_nandbiterrs: rewrite page
[   46.324470] mtd_nandbiterrs: read_page
[   46.328100] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   46.331159] mtd_nandbiterrs: verify_page
[   46.337371] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
[   46.341316] mtd_nandbiterrs: Inserted biterror @ 1/7
[   46.348365] mtd_nandbiterrs: rewrite page
[   46.354123] mtd_nandbiterrs: read_page
[   46.357787] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   46.360846] mtd_nandbiterrs: verify_page
[   46.367047] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
[   46.371003] mtd_nandbiterrs: Inserted biterror @ 1/5
[   46.378046] mtd_nandbiterrs: rewrite page
[   46.383794] mtd_nandbiterrs: read_page
[   46.387475] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   46.390534] mtd_nandbiterrs: verify_page
[   46.396747] mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
[   46.400691] mtd_nandbiterrs: Inserted biterror @ 1/2
[   46.407733] mtd_nandbiterrs: rewrite page
[   46.413483] mtd_nandbiterrs: read_page
[   46.417190] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   46.420222] mtd_nandbiterrs: verify_page
[   46.426419] mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
[   46.430379] mtd_nandbiterrs: Inserted biterror @ 1/0
[   46.437423] mtd_nandbiterrs: rewrite page
[   46.443168] mtd_nandbiterrs: read_page
[   46.446875] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   46.449908] mtd_nandbiterrs: verify_page
[   46.456109] mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
[   46.460066] mtd_nandbiterrs: Inserted biterror @ 2/6
[   46.467109] mtd_nandbiterrs: rewrite page
[   46.472888] mtd_nandbiterrs: read_page
[   46.476569] mtd_nandbiterrs: Read reported 3 corrected bit errors
[   46.479597] mtd_nandbiterrs: verify_page
[   46.485796] mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
[   46.489753] mtd_nandbiterrs: Inserted biterror @ 2/5
[   46.496797] mtd_nandbiterrs: rewrite page
[   46.502540] mtd_nandbiterrs: read_page
[   46.506249] mtd_nandbiterrs: error: read failed at 0x0
[   46.509284] mtd_nandbiterrs: After 9 biterrors per subpage, read reported
error -74
[   46.517867] mtd_nandbiterrs: finished successfully.
[   46.521956] ==================================================
[   47.150313]
[   47.150341] ==================================================
[   47.150867] mtd_nandbiterrs: MTD device: 0
[   47.156564] mtd_nandbiterrs: MTD device size 268435456, eraseblock=131072,
page=2048, oob=128
[   47.160591] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
[   47.169201] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[   47.178778] mtd_nandbiterrs: incremental biterrors test
[   47.181350] mtd_nandbiterrs: write_page
[   47.187334] mtd_nandbiterrs: rewrite page
[   47.191016] mtd_nandbiterrs: read_page
[   47.194997] mtd_nandbiterrs: verify_page
[   47.198019] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
[   47.202081] mtd_nandbiterrs: Inserted biterror @ 0/5
[   47.209132] mtd_nandbiterrs: rewrite page
[   47.214962] mtd_nandbiterrs: read_page
[   47.218554] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   47.221612] mtd_nandbiterrs: verify_page
[   47.227814] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
[   47.231769] mtd_nandbiterrs: Inserted biterror @ 0/2
[   47.238816] mtd_nandbiterrs: rewrite page
[   47.244574] mtd_nandbiterrs: read_page
[   47.248242] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   47.251300] mtd_nandbiterrs: verify_page
[   47.257499] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
[   47.261457] mtd_nandbiterrs: Inserted biterror @ 0/0
[   47.268504] mtd_nandbiterrs: rewrite page
[   47.274301] mtd_nandbiterrs: read_page
[   47.277930] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   47.280987] mtd_nandbiterrs: verify_page
[   47.287187] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
[   47.291145] mtd_nandbiterrs: Inserted biterror @ 1/7
[   47.298191] mtd_nandbiterrs: rewrite page
[   47.303951] mtd_nandbiterrs: read_page
[   47.307619] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   47.310675] mtd_nandbiterrs: verify_page
[   47.316876] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
[   47.320832] mtd_nandbiterrs: Inserted biterror @ 1/5
[   47.327875] mtd_nandbiterrs: rewrite page
[   47.333629] mtd_nandbiterrs: read_page
[   47.337305] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   47.340362] mtd_nandbiterrs: verify_page
[   47.346563] mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
[   47.350519] mtd_nandbiterrs: Inserted biterror @ 1/2
[   47.357561] mtd_nandbiterrs: rewrite page
[   47.363310] mtd_nandbiterrs: read_page
[   47.367021] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   47.370050] mtd_nandbiterrs: verify_page
[   47.376248] mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
[   47.380207] mtd_nandbiterrs: Inserted biterror @ 1/0
[   47.387250] mtd_nandbiterrs: rewrite page
[   47.392996] mtd_nandbiterrs: read_page
[   47.396703] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   47.399737] mtd_nandbiterrs: verify_page
[   47.405936] mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
[   47.409894] mtd_nandbiterrs: Inserted biterror @ 2/6
[   47.416938] mtd_nandbiterrs: rewrite page
[   47.422685] mtd_nandbiterrs: read_page
[   47.426387] mtd_nandbiterrs: Read reported 3 corrected bit errors
[   47.429424] mtd_nandbiterrs: verify_page
[   47.435637] mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
[   47.439582] mtd_nandbiterrs: Inserted biterror @ 2/5
[   47.446624] mtd_nandbiterrs: rewrite page
[   47.452369] mtd_nandbiterrs: read_page
[   47.456080] mtd_nandbiterrs: error: read failed at 0x0
[   47.459111] mtd_nandbiterrs: After 9 biterrors per subpage, read reported
error -74
[   47.467699] mtd_nandbiterrs: finished successfully.
[   47.471784] ==================================================
[   48.080311]
[   48.080339] ==================================================
[   48.080866] mtd_nandbiterrs: MTD device: 0
[   48.086560] mtd_nandbiterrs: MTD device size 268435456, eraseblock=131072,
page=2048, oob=128
[   48.090590] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
[   48.099204] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[   48.108765] mtd_nandbiterrs: incremental biterrors test
[   48.111353] mtd_nandbiterrs: write_page
[   48.117325] mtd_nandbiterrs: rewrite page
[   48.121017] mtd_nandbiterrs: read_page
[   48.124996] mtd_nandbiterrs: verify_page
[   48.128017] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
[   48.132080] mtd_nandbiterrs: Inserted biterror @ 0/5
[   48.139131] mtd_nandbiterrs: rewrite page
[   48.144881] mtd_nandbiterrs: read_page
[   48.148552] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   48.151611] mtd_nandbiterrs: verify_page
[   48.157816] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
[   48.161768] mtd_nandbiterrs: Inserted biterror @ 0/2
[   48.168891] mtd_nandbiterrs: rewrite page
[   48.174571] mtd_nandbiterrs: read_page
[   48.178241] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   48.181299] mtd_nandbiterrs: verify_page
[   48.187500] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
[   48.191455] mtd_nandbiterrs: Inserted biterror @ 0/0
[   48.198506] mtd_nandbiterrs: rewrite page
[   48.204299] mtd_nandbiterrs: read_page
[   48.207931] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   48.210985] mtd_nandbiterrs: verify_page
[   48.217187] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
[   48.221142] mtd_nandbiterrs: Inserted biterror @ 1/7
[   48.228188] mtd_nandbiterrs: rewrite page
[   48.233950] mtd_nandbiterrs: read_page
[   48.237617] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   48.240673] mtd_nandbiterrs: verify_page
[   48.246872] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
[   48.250831] mtd_nandbiterrs: Inserted biterror @ 1/5
[   48.257875] mtd_nandbiterrs: rewrite page
[   48.263631] mtd_nandbiterrs: read_page
[   48.267303] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   48.270361] mtd_nandbiterrs: verify_page
[   48.276560] mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
[   48.280531] mtd_nandbiterrs: Inserted biterror @ 1/2
[   48.287592] mtd_nandbiterrs: rewrite page
[   48.293338] mtd_nandbiterrs: read_page
[   48.297030] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   48.300049] mtd_nandbiterrs: verify_page
[   48.306247] mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
[   48.310205] mtd_nandbiterrs: Inserted biterror @ 1/0
[   48.317250] mtd_nandbiterrs: rewrite page
[   48.322994] mtd_nandbiterrs: read_page
[   48.326705] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   48.329736] mtd_nandbiterrs: verify_page
[   48.335935] mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
[   48.339892] mtd_nandbiterrs: Inserted biterror @ 2/6
[   48.346936] mtd_nandbiterrs: rewrite page
[   48.352633] mtd_nandbiterrs: read_page
[   48.356391] mtd_nandbiterrs: Read reported 3 corrected bit errors
[   48.359423] mtd_nandbiterrs: verify_page
[   48.365626] mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
[   48.369581] mtd_nandbiterrs: Inserted biterror @ 2/5
[   48.376627] mtd_nandbiterrs: rewrite page
[   48.382322] mtd_nandbiterrs: read_page
[   48.386077] mtd_nandbiterrs: error: read failed at 0x0
[   48.389110] mtd_nandbiterrs: After 9 biterrors per subpage, read reported
error -74
[   48.397695] mtd_nandbiterrs: finished successfully.
[   48.401783] ==================================================
[   48.940558]
[   48.940586] ==================================================
[   48.941112] mtd_nandbiterrs: MTD device: 0
[   48.946811] mtd_nandbiterrs: MTD device size 268435456, eraseblock=131072,
page=2048, oob=128
[   48.950837] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
[   48.959448] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[   48.969014] mtd_nandbiterrs: incremental biterrors test
[   48.971596] mtd_nandbiterrs: write_page
[   48.977594] mtd_nandbiterrs: rewrite page
[   48.981277] mtd_nandbiterrs: read_page
[   48.985247] mtd_nandbiterrs: verify_page
[   48.988269] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
[   48.992327] mtd_nandbiterrs: Inserted biterror @ 0/5
[   48.999428] mtd_nandbiterrs: rewrite page
[   49.005508] mtd_nandbiterrs: read_page
[   49.008836] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   49.011858] mtd_nandbiterrs: verify_page
[   49.018061] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
[   49.022015] mtd_nandbiterrs: Inserted biterror @ 0/2
[   49.029058] mtd_nandbiterrs: rewrite page
[   49.034848] mtd_nandbiterrs: read_page
[   49.038516] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   49.041545] mtd_nandbiterrs: verify_page
[   49.047755] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
[   49.051702] mtd_nandbiterrs: Inserted biterror @ 0/0
[   49.058760] mtd_nandbiterrs: rewrite page
[   49.064565] mtd_nandbiterrs: read_page
[   49.068203] mtd_nandbiterrs: Read reported 1 corrected bit errors
[   49.071232] mtd_nandbiterrs: verify_page
[   49.077432] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
[   49.081389] mtd_nandbiterrs: Inserted biterror @ 1/7
[   49.088432] mtd_nandbiterrs: rewrite page
[   49.094197] mtd_nandbiterrs: read_page
[   49.097889] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   49.100919] mtd_nandbiterrs: verify_page
[   49.107121] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
[   49.111077] mtd_nandbiterrs: Inserted biterror @ 1/5
[   49.118137] mtd_nandbiterrs: rewrite page
[   49.123892] mtd_nandbiterrs: read_page
[   49.127576] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   49.130608] mtd_nandbiterrs: verify_page
[   49.136808] mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
[   49.140764] mtd_nandbiterrs: Inserted biterror @ 1/2
[   49.147807] mtd_nandbiterrs: rewrite page
[   49.153607] mtd_nandbiterrs: read_page
[   49.157268] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   49.160294] mtd_nandbiterrs: verify_page
[   49.166496] mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
[   49.170452] mtd_nandbiterrs: Inserted biterror @ 1/0
[   49.177498] mtd_nandbiterrs: rewrite page
[   49.183253] mtd_nandbiterrs: read_page
[   49.186974] mtd_nandbiterrs: Read reported 2 corrected bit errors
[   49.189983] mtd_nandbiterrs: verify_page
[   49.196194] mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
[   49.200140] mtd_nandbiterrs: Inserted biterror @ 2/6
[   49.207182] mtd_nandbiterrs: rewrite page
[   49.212895] mtd_nandbiterrs: read_page
[   49.216671] mtd_nandbiterrs: Read reported 3 corrected bit errors
[   49.219670] mtd_nandbiterrs: verify_page
[   49.225872] mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
[   49.229827] mtd_nandbiterrs: Inserted biterror @ 2/5
[   49.236871] mtd_nandbiterrs: rewrite page
[   49.242629] mtd_nandbiterrs: read_page
[   49.246348] mtd_nandbiterrs: error: read failed at 0x0
[   49.249356] mtd_nandbiterrs: After 9 biterrors per subpage, read reported
error -74
[   49.257958] mtd_nandbiterrs: finished successfully.
[   49.262029] ==================================================
#

Regards,
Gabor


