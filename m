Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950291D9D02
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgESQkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 12:40:17 -0400
Received: from sonic305-2.consmr.mail.bf2.yahoo.com ([74.6.133.41]:41367 "EHLO
        sonic305-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729197AbgESQkR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 12:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1589906416; bh=KB5k1+sCGpSRd9pTKc0P9/4ZGPy9ZVtmix5g8Hf7Eac=; h=Date:From:Reply-To:Subject:References:From:Subject; b=rsShBZf3gXvSp1KE18stC5xzS95cHWZ2qHE2kLpjuydCVuETYTBwEnY1B0wTA0UwLC7ibv/RILe0qeoVtZfZmcS3qFSke8lzxJ5WUfnlE8tI+Ba9u/Lyvb6bSpVVSWY/o6mpgZGWilipoE+//uG7GieYZAblrBzPs1rvuE9fExNR5pIxGX5+KGkwP4+RpR73xkGkz6XbcD8b4R8v5ZfpOSAg+l2ksW8Ze3NaKC7S0VUOXdcs0j459m5WgZSqGDHxpF8WM1f03pKHQRWq7EH4AAZSdm9gvprjMXhxPpqI3Hg68Y9TZ4+oPmwk68e3i3wbzpdTtTX8VwD4nc1Ou84p2g==
X-YMail-OSG: R7VuP90VM1k0EQq_nB4NkpF44DwtvcZVRXDA63d0cCLZj3p6LFCvHmKGpeFDmy3
 WC5Ax.iQB48OdBy9l4C60SnAwjOH0iIfDnABMZMhA6cQpICMznyO1DpK27ecYyTwWAcCvRGJcKMC
 0TQCovOvxQoVhmDhc8Qz1nZsjNTVaGtIViLzSqk.KyOSjjLDmd3ukSGnvI0atLj5xE83AhxhwTa7
 ZHVet3cu6YkpNMJYQP3EZcFmjKl91lGJU68qPuOjtEIfl3I6Qk2bQDEckfAZYQY_rGggErxo4Kmq
 UY9Z9e73Lkyj63rv2FJ4dmI2D5RaFkRPNDK_.D2p2jx8NZ_TpaO1immV.G_k5b7hVkjcRHqop2ji
 p2nyqWIZC6wdSrz0zRwDLmoqhXkNFIJJyB3G9AdrPqhWuIqVzpSSnGsyPBHCL.XaYYB1PajWCSRL
 D.cJwapHFKxMZxoyWGN4Pd1XGnI8vEAByRsz.mPbiAomPfqiM72ukxoTeVgdD_NdzxbdqoVtNB2I
 5N3rHsizZSDcX.FH6rmclZyDhN6NLz4Q.DGZ9RxQzcKBoA0xG1HKh9aM4nJ7qpARC3VuwDu5qUrh
 4ayo7.4WKWKrxZ1WHwSwdLJcXVV_j4qgNNhoShXBLodc3iMOmO6GMb1r36EPXsesQkOUUVRPofd7
 aenj_n1l_fAcEiw7x_UXfkhehLOy0oGm3abLiXJyg8oOE11IxwwX.h58dRZP9S7l7Jl_S6kwkoJW
 2bj6wUDsUXf052e5RUxIpDZM_MV13OfEdtrQQ068p_iOxyBf3vQVmBfo8l5fmVt3GMRr.zho0lt8
 1w0DfVzfY7p1gBcZvLbKWin3RkCZGkcvxtZoMh.kFkfTlMF0JAoc7xsOUkjp3yREtaQ8sjIW9.qZ
 umP4rNOCckkVY0rUE1PiKoN7DqxhPNNqe_7dMHUPjWeMlxFgx2WPrS4twDCGBUjBQc1h9JFeHIvO
 JMeatB0qG8z_BcqNN6xpC6PWby53dEQSOy665aQxlyXWxRudCvTgRT7Ys.v5Ddw6TCMjD.SVZaSh
 Zhj4A0t95R1Dhhfe0FSDoCTtlhc.GQeBvG8rF5JWkygul1cNR8c2XBSVCwWAbx96TPdg4D2iNRK3
 e2MHmS2oNX4le871vhyWusMSSubopQS8Hz2OpZ74s92IYESetC2f47Q76zdozlPyyVhhs8fXzC1V
 XR5nRUheOgaiuU0UKiMVmfXz66VNHNry4vy31ocW.o01NQdICaS2XRisevTjowulC4o7RJ7iqrgJ
 jtf3EjcMDCXuOpxn_2_ZpatI1ETxv_JkIySAwDAToBlJWz8bd6pfzcUwLh2hVOjqqfAOGQhBxT1g
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 19 May 2020 16:40:16 +0000
Date:   Tue, 19 May 2020 16:40:14 +0000 (UTC)
From:   jerom Njitap <jerome.njitap@aol.com>
Reply-To: jeromenjitap100@gmail.com
Message-ID: <2109371352.1082380.1589906414832@mail.yahoo.com>
Subject: SESAME SEED SUPPLY BURKINA FASO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2109371352.1082380.1589906414832.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dear Sir,

This is to bring to your notice that we can supply your needs for
quality Sesame seeds and other products listed below :


Cashew nut
Raw cotton
Sesame seed
Copper cathode
Copper wire scraps
Mazut 100 oil,D6
Used rails
HMS 1/2


We offer the best quality at reasonable prices both on CIF and FOB,
depending on the nature of your offer. Our company has been in this
line of business for over a decade so you you can expect nothing but a
top-notch professional touch and guarantee when you deal or trade with
us.all communication should be through this email address for
confidencial purpose(jeromenjitap100@gmail.com)and your whatsaap number.

Look forward to your response.

Regards
Mr Jerome
