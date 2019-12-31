Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA512D882
	for <lists+linux-spi@lfdr.de>; Tue, 31 Dec 2019 12:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLaL5w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 31 Dec 2019 06:57:52 -0500
Received: from sonic308-1.consmr.mail.bf2.yahoo.com ([74.6.130.40]:43489 "EHLO
        sonic308-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfLaL5w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 31 Dec 2019 06:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577793471; bh=zPC9p8T5S06DA73PD5F75wViZ/EpBpeYylTS7OqjCU4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Snih0VzM2DcYQhNpSfmMpGEW9TDQ/+lnBYKJP+UAFPutQ9A9JjaCWibCjQgRt+brCqgVmOEU+l9FV6f2hMnRgf/Rnu4f92RVnw4mqtHAaGVD18tyVSdE06gYKh/BNnpw52Z4DWR7iOxXdbtn82XVQfJEz82ppGEgesTPwWcKsCY/LLmOpMdGhq9SauHMrT1lWVGpl+yNvO9TqIMEUNFC9GEuZjcw5MnBvTokZ9E7U9sZ8G7DvyrQlcn/S4L40bKGFq64rf06bJfkShFzwqVhylJrpoftTs8BO0sQSg2/4RYWzRMk5tbl7Yv+iSdcglQscShWO5KnK3U+2t9/xSLcOA==
X-YMail-OSG: zptIsRsVM1lstjqzTxaU0ScZEakOVw5i7wHH784vpOL9C_zL2FKCgw6lF3h5Qrg
 j.ROtql1qMadOPiWR0R1fq7S9SOld95PXSl5lwTVDCxS3h.cLnPI7YrZG_paNr70yU0VagnGexLs
 dQ6b9ePEvvWLlxLjXjSil6nSXxMA66Kmc.D9d2cU5En6b.1dOSgr0GO0TV6nroqqxVtpCbKpZ1bh
 vv99eZeExWRGauQLRO9FMLCpSZmdF53WWU38ueeBzXSKn9IMQsTt7JIMj39WpgHDUMPDebyyg4zR
 hdupKlFBNEyMFCowkWIbQi1KB1iSUEIZn9mC8yNRzJrzl9Sgz2JDen9glNX0t2LaGEFgUz3JERxu
 4E3vPaAtm4QoQfbWbavHMHcnGxOs8GirICAw_5SocHvtP0OMQkVyOt9HkjNtSr_IMAzz7eRHiNqT
 vWML62xEARTJkB9PwZ06QQd1grt.lmg1yLdLPbymEVswYd8boRJ0OLVq8ekx1WkIvfX7eRrCWgxG
 QEBUde3SNChPWV8RgjFIFNm4gDNH46mQyRDLz9_PQVvEhA6NjEiUW27XhxHuExWPZIBW2eUbzFgO
 GEaaOs4fycGvn2A4d7s.5SNZzYVXr7JwjTN2h0KbHCaxctB46vpVP21yKg.bQ8ashg5ov5masCkn
 Rj31dEJlExX3EOuLAgbLuc4CyjB4snqHBc8UB6Rla8wugO_X2hRr4UgwM5YD0x171uXGEChZ4noo
 9mhmcFXC3pOj2Kx_ixdxr9J3DmcEStaSvjmy20mMpJEvowAEdogaqpt6JSRgH9Pdp9YGmzxpnMRc
 ubDw53ukyUmjlsKyOX._Mu0IHJqaGK2kBC7bAPg8h6tfDmq24B8bjTVi6ddyGREx6oiPsNCmRenF
 foffLH1cn6tP.cek3FyAnI03rHo16sYAOlmtjRqkRKS8AErtAPGyfmUIBEijxPJHGZbNSuPbSXVa
 FQWjDZiOEPeIqZ8RU91eOf82m.cuCben1dvtgBeD_ulG_ZxEpYxntSmqnBFSBmc_JoQsbkvU4xP6
 9GG1hihaYLJGicyr9FEbnC6U85H88rr4keR7K88xOEduU.a5Z3egUYJpOU0mBmp7nuOCq0tR1aBS
 EZE2R2eDVa9_hwrLAQtI0zTqU0XkMT94tdmiA94AuXT_kPsenO_8XrITeausv5V2KQUP47yrKWeh
 rxEwJzpYyHKaIL5bQYfT_wj9yu6dYJgXi73fzK7st8oN3G5OL29E_OZYg7ZMNgzOIVasUEjY7H0j
 yzHB8d_JhnzWj0FGYsac53omH_0h5HffVXZcOOn.AgePMZePhD4kL62p4i5u87Z7p2LLJ5eP3Z36
 EKkhUC9H9OIdvmw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 31 Dec 2019 11:57:51 +0000
Date:   Tue, 31 Dec 2019 11:57:48 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh101@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <478861359.3386717.1577793468009@mail.yahoo.com>
Subject: YOUR CO-OPERATION FOR THIS TRANSFER.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <478861359.3386717.1577793468009.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:71.0) Gecko/20100101 Firefox/71.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me forsuccess.

Note/ 50% for you why 50% for me after success of the transfer to your bank
account.

Below information is what i need from you so will can be reaching each
other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa Hugh
