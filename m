Return-Path: <linux-spi+bounces-3096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7158CFB4B
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 10:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BE41F20F41
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401F48CFC;
	Mon, 27 May 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="dD/jjLR7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791246453;
	Mon, 27 May 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798309; cv=fail; b=R5dYhwyDkV/aOb/rVN7TNmQrmOAnM5+taR9iIN2Xtc/hh+kd7UqTRRevdo+73fwkVLeLTd141bKPxM2kjLQdYRIkWc1fqZAlWXMEoPfiK187aUWWCiJLh/W+1dS9T8p6PwVOG20a6gt9WHjYW0by8UK55uXwj/BnH4+I1teAhXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798309; c=relaxed/simple;
	bh=JVX+6J6OvcDR5tgJv5hi//fgD7u4sVBIXET0fa8BMZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oa54bpYBhP6WGPIYauZczJcpX8doQ3XFYDfkoLqkPNLrGjR8+LCheUkUJJfTC/wEGaLTxpEEGm7yqToeX0eMDCDHDokA7KzDIf06R5D85DFlL7tv60PGSS84VfjtKzG1S5AK9hPpsshYbFRZwRs0Yntct0V+juTnE+MzucZe/Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=dD/jjLR7; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44QMqiMH030215;
	Mon, 27 May 2024 01:25:04 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ybfgf4jj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 01:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMpWVjAGKRecrJZarzJOHzhlMUowwH+LDP8TkIgpG/CbQ1V+8e4KcQz5+PRNdY/K7yX78/AWgHke7w8gmrq3PtzZBiWEpa5SWvQJrQfdT6QAMer3Amg0mKJYrK9+kqHKJNhRNmHIyc/Z0FXk2zS+9tV1G58cGqjDNN5VNJ9n/RdryGlGL42Vgb3yRr4zRNDfuW++Hhql5l1jKjbg1nk/1UOKkjxe8HZr7YTqepLDPP88Zq/42EUrqH3SJ+mW8dw3CCMoyGkSq5LpBbc2mVAnk+v1glqK8HL3p+PdUvn99PNu2z+fY+iMpEi4i+9cDgZmi/F0myaWhAZFJf8eCWP6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVX+6J6OvcDR5tgJv5hi//fgD7u4sVBIXET0fa8BMZs=;
 b=L+JT/u3r2tsYmBkgtwwdg1XRoflm1lMLJxii1BC1cQA2gzsnvHOP3DQpXvmnhfumXjp9sdmXNeUzbVL4gQZYBFDBr7yUhqLlWMxIznetjddVMMz0Iu16OH0F5vtMZghlGFNB7FDgWgJ98HnFDfn6+nmHlGSk/+2XsH0+LtO6MJ57yWybuWj2E5akhcEoPjSUXWeLufRb1dRDFJXnrBy2a39FanPWF7g/PCMCnw/VHorMrnbF8/Q4nfxev24kxAU5mGT974DAudfdBEvbE6ByIHKD/cAE7ub4OlLJ0nfBSucC1VbIo4Ocq7ZIdx+TRlcYvozm1/OFG6nTLzlNO3jarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVX+6J6OvcDR5tgJv5hi//fgD7u4sVBIXET0fa8BMZs=;
 b=dD/jjLR7zg/5fbpYsUbo4BHRKUg7IVB5UkxN5cP6DQUjZnb9JiDfrdaYZI3fRUSxBIswS86iIlCOTTfR9zWMQ9FmpPdMxCrXCEBMz9B3XfcaZOqacwN9Lj1eV5qXcGcW+leHLY+4O//h8rs6I968u4yLEV2Ukbd8efzg6h/hzvI=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 CH4PR18MB6269.namprd18.prod.outlook.com (2603:10b6:610:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 08:25:02 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:25:01 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 2/5] dt-bindings: spi: cadence: Add MRVL
 overlay bindings documentation for Cadence XSPI
Thread-Topic: [EXTERNAL] Re: [PATCH v4 2/5] dt-bindings: spi: cadence: Add
 MRVL overlay bindings documentation for Cadence XSPI
Thread-Index: AQHaoa0LF2icoBWcPku2cJNyboeMIrGhkBiAgAlKhaA=
Date: Mon, 27 May 2024 08:25:01 +0000
Message-ID: 
 <CO6PR18MB4098E9CF4E90892FCBB45A00B0F02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240509010523.3152264-1-wsadowski@marvell.com>
 <20240509010523.3152264-3-wsadowski@marvell.com>
 <70863d5c-65f8-4baa-99ce-8739ce47fac3@linaro.org>
In-Reply-To: <70863d5c-65f8-4baa-99ce-8739ce47fac3@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|CH4PR18MB6269:EE_
x-ms-office365-filtering-correlation-id: 0a371bca-6759-4014-06bc-08dc7e26811b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eW4wZ1F5bVY3SU9CMENpZ2k4MVBLN3o4UE0yZ1pMNXB1ZkJzcUVGcmVEcFk1?=
 =?utf-8?B?alVpKzJ4SHg4L0I3bjlNbVgyREJUWVMvQjg3djZpSm1VbTNaMWM1QndIbVV0?=
 =?utf-8?B?VVFnalVUNFJMNjRVUkFaNlk2S3dhT1A3eTdJeGRKMGxxRHB1dDVuNEJUTTJE?=
 =?utf-8?B?VlZMODErN2szY0hDTDA0MFZ5V2VoZ0VucUxNOTRKcUloTE8xaXB5WGNBKzd0?=
 =?utf-8?B?L014R2JTWVVyZDZtZXNkSFlXZURnM3Q4blVoRk1sSk5PQlY4NXhOeGwxRCth?=
 =?utf-8?B?UG9wempaeXh5dXVPZjJycEtSWHBqb3dSZFlLb1p4Q0E5cmdEOTNwK3hUSS9v?=
 =?utf-8?B?RWtWZVFoaXpaUkxRU2hIeHVoaHBPYU5KRlEyY2RBUlludDVDS2w4clhVcWRD?=
 =?utf-8?B?SDBQeEh4bmlXM0tiTzZ1dFpHUlBHSThoZVdBa2FmVkQ5bU51WUtXdzNMRWJl?=
 =?utf-8?B?bEdpckswMnVBeW1Ja09DWkJwWXlZZUZwbUNzQUt3L3hpTUUrZDNUN2JOeUtu?=
 =?utf-8?B?MXJMc3pYOVRGMlBZa2MwUkJnSmw2RkpDOXcrYmk4dzRIUVRpQlVTVGphQXRu?=
 =?utf-8?B?UnhBdjZVU1pFRjFIdVE4S0dXNGw2TEg1L2p6NXdPNTRTR3B5Ynp4T1B4V2c0?=
 =?utf-8?B?NlZyblVTRkwvTTRuck9zT1JiM3ZQQ00zRTFqSENxbGRoTjlFc0Q3bmY4MXZz?=
 =?utf-8?B?MEczZi9ES0R1dnhOdy9WOXlEVkFIVklSWUJZeGVtQ2lBT0RkNGN1Q3lTbUpi?=
 =?utf-8?B?d25ncVNDaWN5a2hkY0YraDdESjV3VjJBYmh4eHIzcjFhZzNwZlZVTUNXRnJw?=
 =?utf-8?B?TEhrQU94a05idFpHUWNvU1BnM3JsWXh1dnBoS3diMkgzVGh5UndzQzV2aHBu?=
 =?utf-8?B?VVdEMVBlYnhiWkpUN1poRlNCUmJSRVNlTFNXVzlkOU1WakVxZzZ2M3BJSXJX?=
 =?utf-8?B?TFArNXNEWXNnTC8vUGhDVFUrWEJiYVgrMWEwVlIxTEYxbzVRclBySG8xMmJo?=
 =?utf-8?B?bjdVbE51TVdCSkQ2NHgzZ1BhZmtRekxvdTRBMVcyNVdjWEZUcDNRVm41cU1h?=
 =?utf-8?B?WENubitteUlwdlpQVDBKMCt1Q3RRRG5DaFhXQlpkWTJabXUxTHliaXM5TWpl?=
 =?utf-8?B?ODVydHlJUE1qc21KQ3JqU1lSMTA5TzBYMnM2L0UreVpnNUNYU0NkZGI1MXBH?=
 =?utf-8?B?T0M2KzgxOCs0ZGQzaHNMZEFqWmhvdUd0TjNvSkxVTGtRTUtkVE5iMnAwbGJZ?=
 =?utf-8?B?dEdxVkp0Z09RTXZVZXBCbGgyS2RIa3VwMUZaSFJ2clJsdk5GRDV2ajBEWFFT?=
 =?utf-8?B?MWVrVVhIZWZTV3drT1lBSXpnNTNHWGRDNUgxNVRCSTMzSklkVXZ4ZGdOZVZ4?=
 =?utf-8?B?SWp2bGU3ZlZ6OHhQRWlFMXpyblE1dEgvbWxlRE9LMnRZL2RXTWg5NDhacXZO?=
 =?utf-8?B?RmxZZzAwdTJNdXg5dk1ZMWJNWU9OZEdWamJ6dHdBTnpLYkhRS1NZS2FhNFd6?=
 =?utf-8?B?ZXdpTnE1ZnBZOEd0TUxORWtSbjFxbzArcG5kOHZQTDV4d2ViSXVYQXhqNTVs?=
 =?utf-8?B?bldnU042NUxuem5nSDQ5YTFleGhMUkFVVnZEOTgxQmN2UG9XeE9KTGpQUTYw?=
 =?utf-8?B?eGR5Y2tkY2k4OWR1VmxsZGVHK2ZEeE9PUlpOWkh3QmlFdlZmZE8wRng1YWl4?=
 =?utf-8?B?OHgzY1pLVzFXNGxYSTlMdEZSNTkvWlFIeGtsN3RKb1ZRMTB0dFFnd0RBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZmN6S2tTd3hHT3BRZmd0VlFXcnVjaXVtaFhuNXRhdzRxdnhqOHBSK1hIMDI4?=
 =?utf-8?B?VHorYWlnaWRFcHBjSjRoTEdaQmVwY0NxMEJjZmc4b0lETGY3UUtRRGkyQTZJ?=
 =?utf-8?B?cTZaUE9ITG5qUVFaZ213bVhKM2k3OFNHaUg1Ym1SRytlSDJBdklGbldDMUlt?=
 =?utf-8?B?VUpSOGd4VEY0OWc0K3IwbU1nL01KZzVVQXg1cjJNbUQwaXBMdGNVQ256emp4?=
 =?utf-8?B?YnJOdlRSZzNLQU1iV3FybmcwYnBTbGxXVkQ1a3h1T1F5OTJ1SFRVUGdJNjhi?=
 =?utf-8?B?Lzd6V2NQWGY1MUI1amcycG5tVXh3T3BkVU5GeHovMHVENUxtWVdzMDY5WlVI?=
 =?utf-8?B?empKbmoxRWhGbngvdmkyZGxTYXZUK2x6WE9CcUFjSDc4K3dOT3BEclRiOUx6?=
 =?utf-8?B?YmtEcTRtZ0JaK3VadmgrREpVWHNoWU0wVmJzYisreWlXSUdwWmNnWkJzcTFh?=
 =?utf-8?B?YmcrWFdNa2NBQWQvbk9WZW0xVnZFbS9acHdEZXRZTnNnQ1RReFlHK2M3UWxa?=
 =?utf-8?B?RktjM0ljVTdycEJWaE9JekwwT2pQem1NekpxWGRDRDZScTJCZmhnRmlmeldk?=
 =?utf-8?B?NFZydUhZOG5GUkdWL0ppMGZYSnpLR3NtSmIreTdMcTBMOUE1REs2UkhCRlQ2?=
 =?utf-8?B?V2pjR0lXalJTU085Y1U1WEl6Z3g4R01TcWpjWkJWRHdhdHRkbkZGOEpHNUxH?=
 =?utf-8?B?dDkxWk54ZUxLZElEK3RGZzVSdFZWR0hxNml4QUhKcXgzcGhqei9pTWovdmdz?=
 =?utf-8?B?SDQ5QmkxWFROZDcxaUJBaTJDRXU0SkFjQk9Sa21jNm9uQUo1b01OcTVZWHZj?=
 =?utf-8?B?ek5sZW15TGZYR2dzSzcwZmZUWnJjc2k2Q1FWMTNzRHpjdi90Nlc1c29BNWtY?=
 =?utf-8?B?UU9JR21YVU9RZVQ1U3QzYWJHZGpLMW91K2dReDB4UUdvK0JFWWRyd0l5blJj?=
 =?utf-8?B?b1ZjbWx2UTdtaDRmZm5tYm1QbnRhcHlkR1g2M01FZFVvenhHZExaT1BoU2Jk?=
 =?utf-8?B?M2x4NkQwcm9ndXFHNlAwWDd3RUx2UlBXZ0ZvZFhDUzQvNjMzSFVncVpKSFZv?=
 =?utf-8?B?YXRrSXFINVp0LzNoakpoLzBNbUdXaCttaUJ3dnN4KzF1Z3Z6NnlncE14YVYv?=
 =?utf-8?B?Vi8vQmtOZUxsSkFlUVQ5TytCUmxNelY4MWN5NzQraVFMUHkyOTNhbWE4dXBS?=
 =?utf-8?B?Y3B3ai84VHV5T1ZpVWJBTlBJQUl1aHVjVHBWT0JScFFvdUsxRFFZNVFIZ1ZN?=
 =?utf-8?B?eXFKcjdwZFc3aTU2bWtHOEVRcTA1ZFF6VGFlQnhXcEFLam1HQUVJSmNpK0tu?=
 =?utf-8?B?M0R4QWRJTnpUWEhGSkVTd3liN1JFRER2Q3dmcXcrRmo3eFVqRWVwTzgwZVJv?=
 =?utf-8?B?MDdyMnVnU3pSZ1o2OGJRbDJoS3N0dGlSbHFURTNLYW81V3BxcTVjc3Q5TytK?=
 =?utf-8?B?TnZzZWpNakduZzRtbVpwS21lM0FlbEs5aHo5K1dJSmk3b1VETjkyam5yUFQz?=
 =?utf-8?B?MUZsSmgzc1FNZUxmYy8wYmY2aXhQVkpKUW0ydS9iNGZscTJBMG8yaGN3dko2?=
 =?utf-8?B?QXIyWDVjalhpR0c2cnVKSm1HMldRbXNTZG9YNTJXTjNxVitFTWVrN0pqM3Iy?=
 =?utf-8?B?eEpiYSs1NGUrcDZieWlnOStNYjJJaWd6OFp2UlUvTUFXbHppMXBIVEtIMDNR?=
 =?utf-8?B?b0I3akJNTnNVMnZlYlhKeDYrc1YvbzlSMFdLK3NMRlFCM3JzM2E0U2Z1NnNT?=
 =?utf-8?B?MmRDMEVzVHJZekpqZytVR3hWUGpEdWp3VFhCMkhQRU5EckxwdkVuZkZsbWVQ?=
 =?utf-8?B?OXV6aEVzUjNQZnNYaUZxd0ozakF0dDNEbEVocFYrNHpxSjhEZ2FpRDVtUU92?=
 =?utf-8?B?RE1WbURJVVc1TDFpVFdlM05pdjNDWHBmQ0E3VW8vVFNnS0VObWRCRkQ1NTNO?=
 =?utf-8?B?RU9LWU8vVm1pTmFldnFDN01jTjNBQklUZnZSRE9qcElMTHZvNVB2RGtzMzNT?=
 =?utf-8?B?RVl0M0JFS25ia1Rsb2NNNGxSMnEyeitHbHgxKytzOHNXRDEvODRqbEVLYWRL?=
 =?utf-8?B?WXBWMGRMaUlIRlNZdk4xcFBPQ2t1WVExVmVYb2hCZ2ZYY2NMcTB0Y01XYzQw?=
 =?utf-8?Q?Mw3KRASufCpe6/oo7+PIy5oFo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a371bca-6759-4014-06bc-08dc7e26811b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 08:25:01.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnAkNuBgORzPFsFzNfuAIvtCiIe1g6GviIc6VXen4DttOE1cgFHJDlzg4eCx8ZTavU5lr3MDLD6Mq0zcAngVQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6269
X-Proofpoint-ORIG-GUID: IaMA7QEyffpiEfl_9kAyMP2v0-GMTWBj
X-Proofpoint-GUID: IaMA7QEyffpiEfl_9kAyMP2v0-GMTWBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

PiBPbiAwOS8wNS8yMDI0IDAzOjA1LCBXaXRvbGQgU2Fkb3dza2kgd3JvdGU6DQo+ID4gQWRkIG5l
dyBiaW5kaW5ncyBmb3IgdjIgTWFydmVsbCB4U1BJIG92ZXJsYXk6DQo+ID4gbXJ2bCx4c3BpLW5v
ciAgY29tcGF0aWJsZSBzdHJpbmcNCj4gDQo+IFdoZXJlPw0KPiANCj4gV2h5IGRvdWJsZSBzcGFj
ZT8NCj4gDQo+IHN1YmplY3QgcHJlZml4OiBzcGkgZ29lcyBmaXJzdA0KPiANCj4gUGxlYXNlIHVz
ZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0uIFlvdSBjYW4gZ2V0IHRo
ZW0gZm9yDQo+IGV4YW1wbGUgd2l0aCBgZ2l0IGxvZyAtLW9uZWxpbmUgLS0gRElSRUNUT1JZX09S
X0ZJTEVgIG9uIHRoZSBkaXJlY3RvcnkNCj4geW91ciBwYXRjaCBpcyB0b3VjaGluZy4gRm9yIGJp
bmRpbmdzLCB0aGUgcHJlZmVycmVkIHN1YmplY3RzIGFyZSBleHBsYWluZWQNCj4gaGVyZToNCj4g
aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9f
d3d3Lmtlcm5lbC5vcmdfZG9jX2h0bWxfbGF0ZXN0X2RldmljZXRyZWVfYmluZGluZ3Nfc3VibWl0
dGluZy0NCj4gMkRwYXRjaGVzLmh0bWwtMjNpLTJEZm9yLTJEcGF0Y2gtDQo+IDJEc3VibWl0dGVy
cyZkPUR3SUNhUSZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1HS2djbi1nNlpYLQ0KPiBKbUNM
M1MycUtnVlFodmh2N2h1Mm44RW4tDQo+IGRaYkxUYTgmbT1xZXFKbHE3Y2xPRno5ZjZIQXRkWXcw
UWxjOTViUHRoQWJ3ekxpcDRCSE0zZkR0UV9ySXgtDQo+IFI2V1BGZEt0ak01VCZzPWQyVDdScTVn
TElyWFJLVkRQdjlWRGlHZ2lRVkQ3R0ZBeHc3bEZKMXRndmcmZT0NCj4gDQoNCkxvb2tzIGxpa2Ug
b2xkIGNvbXBhdGlibGUgc3RyaW5nIHdhcyBpbmNsdWRlZCBpbiBjb21taXQgbWVzc2FnZS4NCg0K
PiANCj4gPiBOZXcgY29tcGF0aWJsZSBzdHJpbmcgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiBvcmdp
bmFsIGFuZCBtb2RpZmllZCB4U1BJDQo+ID4gYmxvY2sNCj4gPg0KPiA+IFBIWSBjb25maWd1cmF0
aW9uIHJlZ2lzdGVycw0KPiA+IEFsbG93IHRvIGNoYW5nZSBvcmdpbmFsIHhTUEkgUEhZIGNvbmZp
Z3VyYXRpb24gdmFsdWVzLiBJZiBub3Qgc2V0LCBhbmQNCj4gPiBNYXJ2ZWxsIG92ZXJsYXkgaXMg
ZW5hYmxlZCwgc2FmZSBkZWZhdWx0cyB3aWxsIGJlIHdyaXR0ZW4gaW50byB4U1BJDQo+ID4gUEhZ
DQo+ID4NCj4gPiBPcHRpb25hbCBiYXNlIGZvciB4ZmVyIHJlZ2lzdGVyIHNldA0KPiA+IEFkZGl0
aW9uYWwgcmVnIGZpZWxkIHRvIGFsbG9jYXRlIHhTUEkgTWFydmVsbCBvdmVybGF5IFhGRVIgYmxv
Y2sNCj4gDQo+IEkgaGF2ZSB0cm91YmxlcyByZWFkaW5nIHRoaXMuIElzIHRoaXMgc29tZSBzb3J0
IG9mIG9uZSBsb25nIHNlbnRlbmNlIG9yIGENCj4gbGlzdD8NCj4gDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBXaXRvbGQgU2Fkb3dza2kgPHdzYWRvd3NraUBtYXJ2ZWxsLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2NkbnMseHNwaS55YW1sICAgIHwgNzgg
KysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9jZG5zLHhzcGkueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9jZG5zLHhzcGkueWFtbA0KPiA+IGluZGV4IGViMGY5
MjQ2ODE4NS4uMDk0ZjhiN2ZmYzQ5IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zcGkvY2Rucyx4c3BpLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2NkbnMseHNwaS55YW1sDQo+ID4gQEAgLTE3LDIy
ICsxNyw0MyBAQCBkZXNjcmlwdGlvbjogfA0KPiA+DQo+ID4gIGFsbE9mOg0KPiA+ICAgIC0gJHJl
Zjogc3BpLWNvbnRyb2xsZXIueWFtbCMNCj4gPiArICAtIGlmOg0KPiANCj4gTW92ZSB0aGUgYWxs
T2YgYWZ0ZXIgcmVxdWlyZWQgYmxvY2suDQo+IA0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+
ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAg
ICAgICAgICAgY29uc3Q6IG1hcnZlbGwsY24xMC14c3BpLW5vcg0KPiA+ICsgICAgdGhlbjoNCj4g
PiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICByZWctbmFtZXM6DQo+ID4gKyAgICAg
ICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogaW8NCj4gPiArICAgICAgICAg
ICAgLSBjb25zdDogc2RtYQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBhdXgNCj4gPiArICAg
ICAgICAgICAgLSBjb25zdDogeGZlcmJhc2UNCj4gPiArICAgICAgICByZWc6DQo+ID4gKyAgICAg
ICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogYWRkcmVzcyBhbmQg
bGVuZ3RoIG9mIHRoZSBjb250cm9sbGVyDQo+IHJlZ2lzdGVyIHNldA0KPiA+ICsgICAgICAgICAg
ICAtIGRlc2NyaXB0aW9uOiBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIFNsYXZlIERNQSBkYXRh
DQo+IHBvcnQNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogYWRkcmVzcyBhbmQgbGVu
Z3RoIG9mIHRoZSBhdXhpbGlhcnkNCj4gcmVnaXN0ZXJzDQo+ID4gKyAgICAgICAgICAgIC0gZGVz
Y3JpcHRpb246IGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgeGZlciByZWdpc3RlcnMNCj4gPiAr
ICAgIGVsc2U6DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgcmVnLW5hbWVz
Og0KPiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGlvDQo+
ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHNkbWENCj4gPiArICAgICAgICAgICAgLSBjb25zdDog
YXV4DQo+ID4gKyAgICAgICAgcmVnOg0KPiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAg
ICAgICAgIC0gZGVzY3JpcHRpb246IGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxl
cg0KPiByZWdpc3RlciBzZXQNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogYWRkcmVz
cyBhbmQgbGVuZ3RoIG9mIHRoZSBTbGF2ZSBETUEgZGF0YQ0KPiBwb3J0DQo+ID4gKyAgICAgICAg
ICAgIC0gZGVzY3JpcHRpb246IGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgYXV4aWxpYXJ5DQo+
ID4gKyByZWdpc3RlcnMNCj4gPg0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6
DQo+ID4gLSAgICBjb25zdDogY2Rucyx4c3BpLW5vcg0KPiA+IC0NCj4gPiAtICByZWc6DQo+ID4g
LSAgICBpdGVtczoNCj4gPiAtICAgICAgLSBkZXNjcmlwdGlvbjogYWRkcmVzcyBhbmQgbGVuZ3Ro
IG9mIHRoZSBjb250cm9sbGVyIHJlZ2lzdGVyIHNldA0KPiA+IC0gICAgICAtIGRlc2NyaXB0aW9u
OiBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIFNsYXZlIERNQSBkYXRhIHBvcnQNCj4gPiAtICAg
ICAgLSBkZXNjcmlwdGlvbjogYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBhdXhpbGlhcnkgcmVn
aXN0ZXJzDQo+IA0KPiBXaWRlc3QgY29uc3RyYWludHMgc3RheSBoZXJlLg0KPiANCj4gPiAtDQo+
ID4gLSAgcmVnLW5hbWVzOg0KPiA+IC0gICAgaXRlbXM6DQo+ID4gLSAgICAgIC0gY29uc3Q6IGlv
DQo+ID4gLSAgICAgIC0gY29uc3Q6IHNkbWENCj4gPiAtICAgICAgLSBjb25zdDogYXV4DQo+IA0K
PiBXaWRlc3QgY29uc3RyYWludHMgc3RheSBoZXJlLg0KDQpZYW1sIGZpbGUgd2lsbCBiZSByZXdv
cmtlZCB0byBtYXRjaCBndWlkZWxpbmVzLg0KDQo+IA0KPiA+ICsgICAgZW51bToNCj4gPiArICAg
ICAgLSBjZG5zLHhzcGktbm9yDQo+ID4gKyAgICAgIC0gbWFydmVsbCxjbjEwLXhzcGktbm9yDQo+
ID4NCj4gPiAgICBpbnRlcnJ1cHRzOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiBAQCAtNjgs
NiArODksMzcgQEAgZXhhbXBsZXM6DQo+ID4gICAgICAgICAgICAgICAgICByZWcgPSA8MD47DQo+
ID4gICAgICAgICAgICAgIH07DQo+ID4NCj4gPiArICAgICAgICAgICAgZmxhc2hAMSB7DQo+ID4g
KyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImplZGVjLHNwaS1ub3IiOw0KPiA+ICsgICAg
ICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8NzUwMDAwMDA+Ow0KPiA+ICsgICAgICAg
ICAgICAgICAgcmVnID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgIH07
DQo+ID4gKyAgICB9Ow0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICsgICAgYnVzIHsNCj4gPiArICAgICAg
ICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsN
Cj4gPiArDQo+ID4gKyAgICAgICAgc3BpQGQwMDEwMDAwIHsNCj4gPiArICAgICAgICAgICAgI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0K
PiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1hcnZlbGwsY24xMC14c3BpLW5vciI7DQo+
ID4gKyAgICAgICAgICAgIHJlZyA9IDwweDAgMHhhMDAxMDAwMCAweDAgMHgxMDQwPiwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgPDB4MCAweGIwMDAwMDAwIDB4MCAweDEwMDA+LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICA8MHgwIDB4YTAwMjAwMDAgMHgwIDB4MTAwPiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgPDB4MCAweGEwMDkwMDAwIDB4MCAweDEwMD47DQo+IA0KPiBObyBuZWVkIGZvciBu
ZXcgZXhhbXBsZSBmb3IgZGlmZmVyZW5jZSBpbiBvbmUgcHJvcGVydHkuDQoNCk9rLCBJIHdpbGwg
a2VlcCBvbmx5IG9yaWdpbmFsIG9uZQ0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KDQo=

