Return-Path: <linux-spi+bounces-435-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3C82C375
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jan 2024 17:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5B92852AF
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jan 2024 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DB745C4;
	Fri, 12 Jan 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiO5mjx4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C2745EF
	for <linux-spi@vger.kernel.org>; Fri, 12 Jan 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33677fb38a3so6029453f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 12 Jan 2024 08:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705076352; x=1705681152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B678/c4xhr0E+wnkhweHsOBbqF/dfJtaI5WMmVQ0AQ8=;
        b=WiO5mjx4apaetEsytjz0QiCGKrvpzuLpqZhkgjdnfBffh1KUwZ+/o4bFKrGeV6QOA6
         F+SElbAf4EOE5qVD8gwpHEFzxMN+G8REIK+Yf2tIdJwr0/IHJuakHH+ZunxYsC24R1wH
         w9sEEVboBnCK4/qcMYbEyVqocUkPua4VgDpRASCt4oMlMpbjz8xSsmSdKoJ3Jk//w9Bl
         F6sT7HE3CX7/JmEeBraJyDc8PkiKK9XkRYs7f3sf/4gaSGkZLweNQ+JFJwyQ2zJz1RFm
         A1PPuBAGpGiTyhGQwBiy9ohuJTfeJ8SJFCFUVjS1K0fT9j6DGYVfVg/mOPViIqLohZN0
         wkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705076352; x=1705681152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B678/c4xhr0E+wnkhweHsOBbqF/dfJtaI5WMmVQ0AQ8=;
        b=jLSeOaTBCX7G2GXRPxdoqS98mTGn8Yonx/fG+Syf88PsbTMFv5LrkvoEUWERR8esm9
         TEISB0y/M27rHBEgm1g6maSp9ZQl7SMSBencYGnw43pPcOXWWdrh4QseZKOoFchU8wZD
         4gDvof0qNc6nfYb/jwI1UfR9RwdVcZXEPU7lNlxWjzTIO+mWn8PAJaImcvN5LGbRhZOC
         V7VlF/pPuVwdl9a9jr36Rsa9NP2QbQ2pbbhezpecp3cUvcz/HhoedpoP2Crc/0TJoT+z
         Edex/SpsGV6+EC6dfZcxxCwg625PbDr7XTh6TVZQ0AAoEB21WvQ21Bdtkn3dBNrjvzUu
         Q1NA==
X-Gm-Message-State: AOJu0Yzd652BXu7ZXSEHiUr1qwtIS24xilF+VMbYx3LeILBwjUZgkhg4
	h6wIEe002LxZaq9R5rqqSzWjofiDE80FsHSZGEZzv/9afNo=
X-Google-Smtp-Source: AGHT+IFG050xYSoFHlFPnvvGk4Im2UnuClZUYb7U/lx1CH/iGe0+3+6+XFnAVnb1G4m/3gFI/TZ6AA==
X-Received: by 2002:adf:f590:0:b0:336:4aa6:ff38 with SMTP id f16-20020adff590000000b003364aa6ff38mr924698wro.121.1705076351645;
        Fri, 12 Jan 2024 08:19:11 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id a7-20020adff7c7000000b0033660f75d08sm4256783wrq.116.2024.01.12.08.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:19:11 -0800 (PST)
Message-ID: <4f097d14-dc7f-453e-94f6-96ef568e7770@linaro.org>
Date: Fri, 12 Jan 2024 16:19:10 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] spi: loopback-test: add elapsed time check
To: akinobu.mita@gmail.com,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
Cc: kernel@martin.sperl.org
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
 <1489774651-30170-6-git-send-email-akinobu.mita@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <1489774651-30170-6-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

Trying my luck here.

I'm playing with the spi-s3c64xx.c driver and the spi-loopback-test and
sometimes I see that I get the following error:

```elapsed time x ns is shorter than minimum estimated time y ns```

What's strange to me is that if I ignore the return value of
spi_test_check_elapsed_time(), the test passes, there's no transfer
mismatch and what we expect we actually get at RX.

What kind of errors does the spi_test_check_elapsed_time() check want to
discover? Under what conditions the test->elapsed_time is inaccurate?

Thanks! Find below an example of a test that I run:

/ # modprobe spi-loopback-test simulate_only=0 loopback=1 loop_req=1
check_ranges=1 dump_messages=3 delay_ms=300 run_only_test=14
[ 6748.888603] spi-loopback-test spi13.0: feedback delay set to default (0)
[ 6748.888773] spi-loopback-test spi13.0: Executing spi-loopback-tests
[ 6748.888962] spi-loopback-test spi13.0:   with iteration values: len =
512, tx_off = 0, rx_off = 0
[ 6748.889164] spi-loopback-test spi13.0:   spi_msg@00000000cf23e9a1
[ 6748.889295] spi-loopback-test spi13.0:     frame_length:  0
[ 6748.889417] spi-loopback-test spi13.0:     actual_length: 0
[ 6748.889538] spi-loopback-test spi13.0:     spi_transfer@0000000010068ced
[ 6748.889680] spi-loopback-test spi13.0:       len:    1
[ 6748.889793] spi-loopback-test spi13.0:       tx_buf: 000000009aba786a
[ 6748.889959]           TX: 00000000: 00
[ 6748.890097] spi-loopback-test spi13.0:       rx_buf: 000000000819d83b
[ 6748.890343]           RX: 00000000: aa
[ 6748.890501] spi-loopback-test spi13.0:       rx_buf filled with aa
starts at offset: 0
[ 6748.890788] spi-loopback-test spi13.0:     spi_transfer@00000000cd58625b
[ 6748.891045] spi-loopback-test spi13.0:       len:    512
[ 6748.891247] spi-loopback-test spi13.0:       tx_buf: 0000000062a28e45
[ 6748.891494]           TX: 00000000: 01 02 03 04 05 06 07 08 09 0a 0b
0c 0d 0e 0f 10
[ 6748.891786]           TX: 00000010: 11 12 13 14 15 16 17 18 19 1a 1b
1c 1d 1e 1f 20
[ 6748.892079]           TX: 00000020: 21 22 23 24 25 26 27 28 29 2a 2b
2c 2d 2e 2f 30
[ 6748.892371]           TX: 00000030: 31 32 33 34 35 36 37 38 39 3a 3b
3c 3d 3e 3f 40
[ 6748.892664]           TX: 00000040: 41 42 43 44 45 46 47 48 49 4a 4b
4c 4d 4e 4f 50
[ 6748.892957]           TX: 00000050: 51 52 53 54 55 56 57 58 59 5a 5b
5c 5d 5e 5f 60
[ 6748.893249]           TX: 00000060: 61 62 63 64 65 66 67 68 69 6a 6b
6c 6d 6e 6f 70
[ 6748.893542]           TX: 00000070: 71 72 73 74 75 76 77 78 79 7a 7b
7c 7d 7e 7f 80
[ 6748.893835]           TX: 00000080: 81 82 83 84 85 86 87 88 89 8a 8b
8c 8d 8e 8f 90
[ 6748.894128]           TX: 00000090: 91 92 93 94 95 96 97 98 99 9a 9b
9c 9d 9e 9f a0
[ 6748.894420]           TX: 000000a0: a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab
ac ad ae af b0
[ 6748.894719]           TX: 000000b0: b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb
bc bd be bf c0
[ 6748.895006]           TX: 000000c0: c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb
cc cd ce cf d0
[ 6748.895298]           TX: 000000d0: d1 d2 d3 d4 d5 d6 d7 d8 d9 da db
dc dd de df e0
[ 6748.895591]           TX: 000000e0: e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb
ec ed ee ef f0
[ 6748.895883]           TX: 000000f0: f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb
fc fd fe ff 00
[ 6748.896176]           TX: 00000100: 01 02 03 04 05 06 07 08 09 0a 0b
0c 0d 0e 0f 10
[ 6748.896469]           TX: 00000110: 11 12 13 14 15 16 17 18 19 1a 1b
1c 1d 1e 1f 20
[ 6748.896762]           TX: 00000120: 21 22 23 24 25 26 27 28 29 2a 2b
2c 2d 2e 2f 30
[ 6748.897059]           TX: 00000130: 31 32 33 34 35 36 37 38 39 3a 3b
3c 3d 3e 3f 40
[ 6748.897347]           TX: 00000140: 41 42 43 44 45 46 47 48 49 4a 4b
4c 4d 4e 4f 50
[ 6748.897639]           TX: 00000150: 51 52 53 54 55 56 57 58 59 5a 5b
5c 5d 5e 5f 60
[ 6748.897932]           TX: 00000160: 61 62 63 64 65 66 67 68 69 6a 6b
6c 6d 6e 6f 70
[ 6748.898225]           TX: 00000170: 71 72 73 74 75 76 77 78 79 7a 7b
7c 7d 7e 7f 80
[ 6748.898525]           TX: 00000180: 81 82 83 84 85 86 87 88 89 8a 8b
8c 8d 8e 8f 90
[ 6748.898811]           TX: 00000190: 91 92 93 94 95 96 97 98 99 9a 9b
9c 9d 9e 9f a0
[ 6748.899103]           TX: 000001a0: a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab
ac ad ae af b0
[ 6748.899396]           TX: 000001b0: b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb
bc bd be bf c0
[ 6748.899688]           TX: 000001c0: c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb
cc cd ce cf d0
[ 6748.899981]           TX: 000001d0: d1 d2 d3 d4 d5 d6 d7 d8 d9 da db
dc dd de df e0
[ 6748.900274]           TX: 000001e0: e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb
ec ed ee ef f0
[ 6748.900567]           TX: 000001f0: f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb
fc fd fe ff 00
[ 6748.900860] spi-loopback-test spi13.0:       rx_buf: 00000000df223723
[ 6748.901105]           RX: 00000000: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.901398]           RX: 00000010: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.901696]           RX: 00000020: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.901983]           RX: 00000030: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.902276]           RX: 00000040: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.902575]           RX: 00000050: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.902861]           RX: 00000060: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.903154]           RX: 00000070: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.903447]           RX: 00000080: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.903739]           RX: 00000090: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.904036]           RX: 000000a0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.904325]           RX: 000000b0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.904618]           RX: 000000c0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.904910]           RX: 000000d0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.905203]           RX: 000000e0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.905496]           RX: 000000f0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.905788]           RX: 00000100: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.906081]           RX: 00000110: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.906373]           RX: 00000120: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.906675]           RX: 00000130: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.906985]           RX: 00000140: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.907251]           RX: 00000150: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.907544]           RX: 00000160: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.907836]           RX: 00000170: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.908129]           RX: 00000180: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.908422]           RX: 00000190: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.908714]           RX: 000001a0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.909007]           RX: 000001b0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.909300]           RX: 000001c0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.909592]           RX: 000001d0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.909885]           RX: 000001e0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.910177]           RX: 000001f0: aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa
[ 6748.910482] spi-loopback-test spi13.0:       rx_buf filled with aa
starts at offset: 0
[ 6748.910773] spi-loopback-test spi13.0:     spi_transfer@00000000774992f1
[ 6748.911035] spi-loopback-test spi13.0:       len:    1
[ 6748.911225] spi-loopback-test spi13.0:       tx_buf: 00000000401e03ed
[ 6748.911472]           TX: 00000000: 01
[ 6748.911614] spi-loopback-test spi13.0:       rx_buf: 0000000010f7e3e4
[ 6748.911860]           RX: 00000000: aa
[ 6748.912004] spi-loopback-test spi13.0:       rx_buf filled with aa
starts at offset: 0

[ 6748.913400] spi-loopback-test spi13.0: elapsed time 532837 ns is
shorter than minimum estimated time 82240000 ns

[ 6748.913611] spi-loopback-test spi13.0:   spi_msg@00000000cf23e9a1
[ 6748.913741] spi-loopback-test spi13.0:     frame_length:  514
[ 6748.913863] spi-loopback-test spi13.0:     actual_length: 514
[ 6748.913985] spi-loopback-test spi13.0:     spi_transfer@0000000010068ced
[ 6748.914222] spi-loopback-test spi13.0:       len:    1
[ 6748.914418] spi-loopback-test spi13.0:       tx_buf: 000000009aba786a
[ 6748.914673]           TX: 00000000: 00
[ 6748.914808] spi-loopback-test spi13.0:       rx_buf: 000000000819d83b
[ 6748.915053]           RX: 00000000: 00
[ 6748.915197] spi-loopback-test spi13.0:     spi_transfer@00000000cd58625b
[ 6748.915453] spi-loopback-test spi13.0:       len:    512
[ 6748.915656] spi-loopback-test spi13.0:       tx_buf: 0000000062a28e45
[ 6748.915901]           TX: 00000000: 01 02 03 04 05 06 07 08 09 0a 0b
0c 0d 0e 0f 10
[ 6748.916194]           TX: 00000010: 11 12 13 14 15 16 17 18 19 1a 1b
1c 1d 1e 1f 20
[ 6748.916492]           TX: 00000020: 21 22 23 24 25 26 27 28 29 2a 2b
2c 2d 2e 2f 30
[ 6748.916780]           TX: 00000030: 31 32 33 34 35 36 37 38 39 3a 3b
3c 3d 3e 3f 40
[ 6748.917072]           TX: 00000040: 41 42 43 44 45 46 47 48 49 4a 4b
4c 4d 4e 4f 50
[ 6748.917365]           TX: 00000050: 51 52 53 54 55 56 57 58 59 5a 5b
5c 5d 5e 5f 60
[ 6748.917658]           TX: 00000060: 61 62 63 64 65 66 67 68 69 6a 6b
6c 6d 6e 6f 70
[ 6748.917950]           TX: 00000070: 71 72 73 74 75 76 77 78 79 7a 7b
7c 7d 7e 7f 80
[ 6748.918243]           TX: 00000080: 81 82 83 84 85 86 87 88 89 8a 8b
8c 8d 8e 8f 90
[ 6748.918539]           TX: 00000090: 91 92 93 94 95 96 97 98 99 9a 9b
9c 9d 9e 9f a0
[ 6748.918833]           TX: 000000a0: a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab
ac ad ae af b0
[ 6748.919121]           TX: 000000b0: b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb
bc bd be bf c0
[ 6748.919414]           TX: 000000c0: c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb
cc cd ce cf d0
[ 6748.919706]           TX: 000000d0: d1 d2 d3 d4 d5 d6 d7 d8 d9 da db
dc dd de df e0
[ 6748.919999]           TX: 000000e0: e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb
ec ed ee ef f0
[ 6748.920292]           TX: 000000f0: f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb
fc fd fe ff 00
[ 6748.920584]           TX: 00000100: 01 02 03 04 05 06 07 08 09 0a 0b
0c 0d 0e 0f 10
[ 6748.920877]           TX: 00000110: 11 12 13 14 15 16 17 18 19 1a 1b
1c 1d 1e 1f 20
[ 6748.921174]           TX: 00000120: 21 22 23 24 25 26 27 28 29 2a 2b
2c 2d 2e 2f 30
[ 6748.921463]           TX: 00000130: 31 32 33 34 35 36 37 38 39 3a 3b
3c 3d 3e 3f 40
[ 6748.921755]           TX: 00000140: 41 42 43 44 45 46 47 48 49 4a 4b
4c 4d 4e 4f 50
[ 6748.922048]           TX: 00000150: 51 52 53 54 55 56 57 58 59 5a 5b
5c 5d 5e 5f 60
[ 6748.922341]           TX: 00000160: 61 62 63 64 65 66 67 68 69 6a 6b
6c 6d 6e 6f 70
[ 6748.922636]           TX: 00000170: 71 72 73 74 75 76 77 78 79 7a 7b
7c 7d 7e 7f 80
[ 6748.922926]           TX: 00000180: 81 82 83 84 85 86 87 88 89 8a 8b
8c 8d 8e 8f 90
[ 6748.923219]           TX: 00000190: 91 92 93 94 95 96 97 98 99 9a 9b
9c 9d 9e 9f a0
[ 6748.923516]           TX: 000001a0: a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab
ac ad ae af b0
[ 6748.923804]           TX: 000001b0: b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb
bc bd be bf c0
[ 6748.924097]           TX: 000001c0: c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb
cc cd ce cf d0
[ 6748.924390]           TX: 000001d0: d1 d2 d3 d4 d5 d6 d7 d8 d9 da db
dc dd de df e0
[ 6748.924682]           TX: 000001e0: e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb
ec ed ee ef f0
[ 6748.924975]           TX: 000001f0: f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb
fc fd fe ff 00
[ 6748.925268] spi-loopback-test spi13.0:       rx_buf: 00000000df223723
[ 6748.925514]           RX: 00000000: 01 02 03 04 05 06 07 08 09 0a 0b
0c 0d 0e 0f 10
[ 6748.925811]           RX: 00000010: 11 12 13 14 15 16 17 18 19 1a 1b
1c 1d 1e 1f 20
[ 6748.926099]           RX: 00000020: 21 22 23 24 25 26 27 28 29 2a 2b
2c 2d 2e 2f 30
[ 6748.926392]           RX: 00000030: 31 32 33 34 35 36 37 38 39 3a 3b
3c 3d 3e 3f 40
[ 6748.926687]           RX: 00000040: 41 42 43 44 45 46 47 48 49 4a 4b
4c 4d 4e 4f 50
[ 6748.926977]           RX: 00000050: 51 52 53 54 55 56 57 58 59 5a 5b
5c 5d 5e 5f 60
[ 6748.927270]           RX: 00000060: 61 62 63 64 65 66 67 68 69 6a 6b
6c 6d 6e 6f 70
[ 6748.927562]           RX: 00000070: 71 72 73 74 75 76 77 78 79 7a 7b
7c 7d 7e 7f 80
[ 6748.927855]           RX: 00000080: 81 82 83 84 85 86 87 88 89 8a 8b
8c 8d 8e 8f 90
[ 6748.928153]           RX: 00000090: 91 92 93 94 95 96 97 98 99 9a 9b
9c 9d 9e 9f a0
[ 6748.928440]           RX: 000000a0: a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab
ac ad ae af b0
[ 6748.928733]           RX: 000000b0: b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb
bc bd be bf c0
[ 6748.929026]           RX: 000000c0: c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb
cc cd ce cf d0
[ 6748.929318]           RX: 000000d0: d1 d2 d3 d4 d5 d6 d7 d8 d9 da db
dc dd de df e0
[ 6748.929611]           RX: 000000e0: e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb
ec ed ee ef f0
[ 6748.929904]           RX: 000000f0: f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb
fc fd fe ff 00
[ 6748.930197]           RX: 00000100: 01 02 03 04 05 06 07 08 09 0a 0b
0c 0d 0e 0f 10
[ 6748.930493]           RX: 00000110: 11 12 13 14 15 16 17 18 19 1a 1b
1c 1d 1e 1f 20
[ 6748.930782]           RX: 00000120: 21 22 23 24 25 26 27 28 29 2a 2b
2c 2d 2e 2f 30
[ 6748.931074]           RX: 00000130: 31 32 33 34 35 36 37 38 39 3a 3b
3c 3d 3e 3f 40
[ 6748.931367]           RX: 00000140: 41 42 43 44 45 46 47 48 49 4a 4b
4c 4d 4e 4f 50
[ 6748.931660]           RX: 00000150: 51 52 53 54 55 56 57 58 59 5a 5b
5c 5d 5e 5f 60
[ 6748.931953]           RX: 00000160: 61 62 63 64 65 66 67 68 69 6a 6b
6c 6d 6e 6f 70
[ 6748.932245]           RX: 00000170: 71 72 73 74 75 76 77 78 79 7a 7b
7c 7d 7e 7f 80
[ 6748.932538]           RX: 00000180: 81 82 83 84 85 86 87 88 89 8a 8b
8c 8d 8e 8f 90
[ 6748.932836]           RX: 00000190: 91 92 93 94 95 96 97 98 99 9a 9b
9c 9d 9e 9f a0
[ 6748.933123]           RX: 000001a0: a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab
ac ad ae af b0
[ 6748.933416]           RX: 000001b0: b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb
bc bd be bf c0
[ 6748.933709]           RX: 000001c0: c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb
cc cd ce cf d0
[ 6748.934001]           RX: 000001d0: d1 d2 d3 d4 d5 d6 d7 d8 d9 da db
dc dd de df e0
[ 6748.934294]           RX: 000001e0: e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb
ec ed ee ef f0
[ 6748.934589]           RX: 000001f0: f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb
fc fd fe ff 00
[ 6748.934880] spi-loopback-test spi13.0:     spi_transfer@00000000774992f1
[ 6748.935140] spi-loopback-test spi13.0:       len:    1
[ 6748.935332] spi-loopback-test spi13.0:       tx_buf: 00000000401e03ed
[ 6748.935578]           TX: 00000000: 01
[ 6748.935721] spi-loopback-test spi13.0:       rx_buf: 0000000010f7e3e4
[ 6748.935967]           RX: 00000000: 01
[ 6749.236147] spi-loopback-test spi13.0: Finished spi-loopback-tests
with return: 0

On 3/17/17 18:17, Akinobu Mita wrote:
> This adds checks whether the elapsed time is longer than the minimam
> estimated time.  The estimated time is calculated with the total
> transfer length per clock rate and optional spi_transfer.delay_usecs.
> 
> Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-loopback-test.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-test.h          |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
> index 6df6ddd..66e8cfd0 100644
> --- a/drivers/spi/spi-loopback-test.c
> +++ b/drivers/spi/spi-loopback-test.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
> +#include <linux/ktime.h>
>  #include <linux/list.h>
>  #include <linux/list_sort.h>
>  #include <linux/module.h>
> @@ -479,6 +480,35 @@ static int spi_check_rx_ranges(struct spi_device *spi,
>  	return ret;
>  }
>  
> +static int spi_test_check_elapsed_time(struct spi_device *spi,
> +				       struct spi_test *test)
> +{
> +	int i;
> +	unsigned long long estimated_time = 0;
> +	unsigned long long delay_usecs = 0;
> +
> +	for (i = 0; i < test->transfer_count; i++) {
> +		struct spi_transfer *xfer = test->transfers + i;
> +		unsigned long long nbits = BITS_PER_BYTE * xfer->len;
> +
> +		delay_usecs += xfer->delay_usecs;
> +		if (!xfer->speed_hz)
> +			continue;
> +		estimated_time += div_u64(nbits * NSEC_PER_SEC, xfer->speed_hz);
> +	}
> +
> +	estimated_time += delay_usecs * NSEC_PER_USEC;
> +	if (test->elapsed_time < estimated_time) {
> +		dev_err(&spi->dev,
> +			"elapsed time %lld ns is shorter than minimam estimated time %lld ns\n",
> +			test->elapsed_time, estimated_time);
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int spi_test_check_loopback_result(struct spi_device *spi,
>  					  struct spi_message *msg,
>  					  void *tx, void *rx)
> @@ -817,12 +847,16 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
>  
>  	/* only if we do not simulate */
>  	if (!simulate_only) {
> +		ktime_t start;
> +
>  		/* dump the complete message before and after the transfer */
>  		if (dump_messages == 3)
>  			spi_test_dump_message(spi, msg, true);
>  
> +		start = ktime_get();
>  		/* run spi message */
>  		ret = spi_sync(spi, msg);
> +		test->elapsed_time = ktime_to_ns(ktime_sub(ktime_get(), start));
>  		if (ret == -ETIMEDOUT) {
>  			dev_info(&spi->dev,
>  				 "spi-message timed out - reruning...\n");
> @@ -848,6 +882,10 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
>  
>  		/* run rx-buffer tests */
>  		ret = spi_test_check_loopback_result(spi, msg, tx, rx);
> +		if (ret)
> +			goto exit;
> +
> +		ret = spi_test_check_elapsed_time(spi, test);
>  	}
>  
>  	/* if requested or on error dump message (including data) */
> diff --git a/drivers/spi/spi-test.h b/drivers/spi/spi-test.h
> index 82fff4a..6ed7b89 100644
> --- a/drivers/spi/spi-test.h
> +++ b/drivers/spi/spi-test.h
> @@ -75,6 +75,7 @@
>   * @fill_option:      define the way how tx_buf is filled
>   * @fill_pattern:     fill pattern to apply to the tx_buf
>   *                    (used in some of the @fill_options)
> + * @elapsed_time:     elapsed time in nanoseconds
>   */
>  
>  struct spi_test {
> @@ -108,6 +109,7 @@ struct spi_test {
>  #define FILL_TRANSFER_BYTE_32 11 /* fill with the transfer byte - 32 bit */
>  #define FILL_TRANSFER_NUM     16 /* fill with the transfer number */
>  	u32 fill_pattern;
> +	unsigned long long elapsed_time;
>  };
>  
>  /* default implementation for @spi_test.run_test */

