Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133014048B5
	for <lists+linux-spi@lfdr.de>; Thu,  9 Sep 2021 12:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhIIKwf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Sep 2021 06:52:35 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:14326 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232903AbhIIKwf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Sep 2021 06:52:35 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1896onVx002355;
        Thu, 9 Sep 2021 05:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=vV2E/bPOCiDXIXiqkPzy5Kt8Vs/IvVSFsRIuqXLKxFM=;
 b=Zi3ZOHlhXIMKHtWoluEvl5r/O6KDehvSF4IeYn92I4aqALLZ6EbaFQxPZf255JFdXfQr
 YhNMRLOCJ0ba9XYImKxI9M5KEL32Esahuqwi65UQq8m21VBvw8IrRRYDNevg95FaNaM8
 HsoMVs2ttqCTn4ARVXF8EhNYwhYgUtZ5wFVdXRM5qJG0pbUOXc0+i9/3bABrHfYdffPJ
 qvumz9yOpFYMywHT/IU8EpuktezzEbOR5tvCBI0u8lpnqP218T3ag2HHCyvgIe6YwDjO
 Lj+i+IEtesZMD4BIQ5nIToSoncWah9Au3aOYmEXSZD47IACbDuVaSvsb8JLaFjxct7jq cw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3ay8n60dna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Sep 2021 05:51:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 9 Sep
 2021 11:51:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 9 Sep 2021 11:51:21 +0100
Received: from [198.61.64.231] (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 565E3478;
        Thu,  9 Sep 2021 10:51:21 +0000 (UTC)
Subject: Re: [PATCH 03/10] spi: Add flag for no TX after a RX in the same Chip
 Select
To:     Mark Brown <broonie@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
 <20210908113450.788452-4-tanureal@opensource.cirrus.com>
 <20210908123734.GF4112@sirena.org.uk>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
Message-ID: <7dc20785-95da-6599-49dc-8e5f805d6a14@opensource.cirrus.com>
Date:   Thu, 9 Sep 2021 11:51:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908123734.GF4112@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Pmt-t4LicdzZ8Q9yaFx4gS45mSJbI8b2
X-Proofpoint-GUID: Pmt-t4LicdzZ8Q9yaFx4gS45mSJbI8b2
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 9/8/21 1:37 PM, Mark Brown wrote:
> On Wed, Sep 08, 2021 at 12:34:44PM +0100, Lucas Tanure wrote:
>> Some controllers can't write to the bus after a read without
>> releasing the chip select, so add flag and a check in spi core
> 
> Nothing you've added ever reads this flag and I'm not sure what anything
> would be able to constructively do with it so why add the flag?  I don't
> understand what the use case is.
> 
__spi_validate checks this flag and makes sure the message can be 
received by the controller.
__spi_validate can't fix the message, so it only rejects the message.
