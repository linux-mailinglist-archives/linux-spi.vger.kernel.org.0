Return-Path: <linux-spi+bounces-7309-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75169A7145F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 11:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603C47A6266
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D1C1A08B8;
	Wed, 26 Mar 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oYik93Py"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CD8C1F;
	Wed, 26 Mar 2025 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983449; cv=fail; b=FpnAYnEA2O72wO55NgZhsXff3MAhRdquK8lAgQ3NN0klRblPSJDiwls9QL2YFczO/EC9raP6OpB38OmLZFdDtgsvoiJcDJtvM3Fhce0dxj91r8ayFh+h54qaPubxXc0KqSM8YfkgUCh/7uoa1GQyj/fNg04k6K8TsAz//Wic/rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983449; c=relaxed/simple;
	bh=sL7gGTtUn9q5nL/IiMwtKWdkh+mhE1hT5YoeLy3qUkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aYJbUED2VEtYgdLMXpDWY+0Udpio/z7LEvAJIjJqEhl07kvsIOYWW8PqzAVJUC7fwSpa8iVfAwfbZeI/D5hT/iV/HQZL0wqyy85Xi1ldaANwcVEWLL2JooB++WPBM8c7Sv80GEy77O4culSN1/4dVRwThpw9f/94x8nb2kwbILA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oYik93Py; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHdWFH88/Ipb0UeTqf+6LCyxMUySEMh6XztVR9wwOJ/5LrSwS4aO+df1EfqafOJa4kHkgWEcvNYgQni2XmVyh/FLZyj4kNKfysAXxNks6od87ftc5Dp99nFEC2JgiwESsROVZImICZJEnTtiG1lZ/e/ONZYpAfjK8FVu0bWVO3wdXVcLO5zIRY/bVQ4+pHxLq2bSRBFqt5wyZKpir9zdYbBuSU9YODQoP6bPHbcXAGNFT1dU0Y8PVStTieKnvCv/gjIoKFAdpeODurSIDU5+9tnT1/zkV8QJUjrBDgyoCtrsgqjxRKZrRV2QJygc3hx5o3kHK2GvFmM4UfYv5PbDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VicG7JpJLd+kK3apCxZtp4dmKpgoF2r3grphMGeZ2K0=;
 b=pcXb8bGG0SAzuVT5L78CDAh/XZvf92m5xn04aMx1HnOc6sHQlDXidPlqfttTT5M2bsGaba1GvmKDY/qmkwpP+zeX8cWJC+WW1WsHCg98hDU2flsKGAkrFAILlSWI+gpViNhTQFvHyIs9f8uUzY28WuKpSIx7VzA5xthwdzfeYfh4ljX3QBVq1sa5T5HK+f6HEnz+ZoORaurHk8WSs+D24QaZGxzv6TFOteUXbNHG3JeC28YdwNxlMhEtPRWr3/f3S1KZ4lZx4+Y/8c1x1WBYh2kUXw+bpeSbvMZ930PfHYkNdTXuyWef+e9lm4EHizyd0ZXtqaIZ4hW+FRZXvcdiLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VicG7JpJLd+kK3apCxZtp4dmKpgoF2r3grphMGeZ2K0=;
 b=oYik93Py0ml4SQSuyGp03HvXeMfCEgzolUT+BsP+2RKcfnYCG255RCPs8BEk8gk4YJMe4Bl7H+RFwghxetpLKSeJWhQQ+SwaYLa3PxgLJrWU3LO/rbdQt94/Kf1G56ugegN18CeOgi7YLnKDOiW5hRO/nXGXYUsS3XoWKslsxok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 10:04:06 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 10:04:06 +0000
Message-ID: <2f0477df-7228-4cb0-ad08-52a35f2976e1@amd.com>
Date: Wed, 26 Mar 2025 15:33:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] spi: espi_amd: Add eSPI set config IOCTL command
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <20250313183440.261872-3-Raju.Rangoju@amd.com>
 <6c09f5e0-d8a2-419c-8813-8a1bb4f39428@sirena.org.uk>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <6c09f5e0-d8a2-419c-8813-8a1bb4f39428@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::15) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: a2712dff-f9a6-4e11-2203-08dd6c4d8afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3N0MG8wRUNhSGorandGNS94YW5jdFVUY054dm4wSUVFVVZMVEF3aFhuQ1BP?=
 =?utf-8?B?Y0ZtbkM4L2o3Rm9NMm0yTU5WYzlkZ3UyMUM3SW44ZmxnUWFYckxaYWVucFhL?=
 =?utf-8?B?aXJHZWpqa2EzR1ZKY1dXZFJlT2QxZGZoOGg1emducC9RU1psUDYrYmR2cm1w?=
 =?utf-8?B?QWJpUEx1NDVINTlIZXF4Mm1ZeGV5Q2dzaXJpYk1xeWNZa3dKY3ZNR3RZZ3lZ?=
 =?utf-8?B?cmJuQmZ4NnlINWFxN2lMZWgyN0d0MU9sQ3RWSzVFVE9BUEFCQ2RweThFN2RW?=
 =?utf-8?B?RmVGZndlanhabCs0ZzA4ZzE4QktjQmw4czRBdG1jeWRta2t2WGphYWhOWnBy?=
 =?utf-8?B?MXdCa3FKVEJVU2FsbmNCdFhuOWIxdWd3TExWTmxGeDBreXdtanRFRklqMXhB?=
 =?utf-8?B?WGcxamlWeTY0aW5qcjRTenlQVDdNeHVOWEIzUlhGUXZIdWhIMVErNkd0V1Mr?=
 =?utf-8?B?eTFaWXpSS3pGV3ZSYWEvOGNNNXoxektaSGozbTlhV2lXNnpHNWptSU00WmMx?=
 =?utf-8?B?bUJvOEZJOFI1TE9BRU5wNXo4SWl3V3pXMTN6dTdqd0tmTWtwWGJ1dTl5dXFR?=
 =?utf-8?B?NzBpU2Rzc2x0T0JCZlBjMExncmNRQ2ZIaHZNbVpTbWYzK084a3pXN0FxSHJh?=
 =?utf-8?B?TkZsNWJmaEp1WGFmc3pHRjlOMmhscnBwcGt5R3dqbCt0QmlVZDJ0NDduZnhi?=
 =?utf-8?B?TlRGK2xLMzgxTVRTNUJSY3dYVTB2NWFyVlBENWM0cGI4VVcyaUNEVWFadHdP?=
 =?utf-8?B?ZEJMR3ZXdXE5TlhMb1hodVpHeXRpWG5pbXdNMzBZU2dSRisrT2N1QWd0WEpu?=
 =?utf-8?B?WlkrcXcvcy9kcGQ0L05hOXRHcldtOVJIZFN4WGtEVTFHWHp3eDlMTm81R1pI?=
 =?utf-8?B?WlhUcXIzb1BEV0tRSFNHUDh1UHRjQTAzaHcvS2I4dStGZjlwZDRydWIrQkt2?=
 =?utf-8?B?aE9hOGllTDdFOEdEc01FbGFHZkRaamZ1L1NWWjViRTFxZnRlWE9zb3pUSUd5?=
 =?utf-8?B?em1ZUVlzOTdlNGZrMlRqOXd4TEo1WEh1REJnaWt5MkJOcEplWVlaK2VTa21n?=
 =?utf-8?B?ZUFUemlBc1ZmQXpaU01hNE0vNVFaSWNGR2NyU1Z2TmNYVXp0ZytoSnBiNzJa?=
 =?utf-8?B?RCtoenlYYTFyQ0oxN2s4T2pXdk5CSytHdFFsQzVjVlF5S2llNW9DRzlBUE1F?=
 =?utf-8?B?QVhwVHBvWEhMdm90bUVjaW9xQytsQzJvbG94OUsweStRMUJxdUJpd3hwRGlK?=
 =?utf-8?B?aVRZQ3lWRTZKTU81cGp3UlpnN3k5Y21Da3ZoY1RJdHloSXQ2ckpMQ0IzWmJi?=
 =?utf-8?B?cjRVdE1FcFJOVnpNa2U0VEpTZklBMHdSZEE0SmY1aHAwSi9OQ3R4bXp6REZa?=
 =?utf-8?B?ZnlPUjA0K00zTm5EZ3NWb2wxSWkxT3VWdWVwVXllN2dPV3BQQXBFR0d2M3Ju?=
 =?utf-8?B?NFJ4Z2dsZVdNaFZCMjlkUEwvaS84K1FDZ1ZpMUlGWFJsVy94YjdFRldHbWF5?=
 =?utf-8?B?MG5iSjBvd2Q1SG04eXMraXNYZUNsSVM2dkRuV010eW5IRUdSaEhYMklaQUhE?=
 =?utf-8?B?K1dHd2RMQUZuT0kzeSt0RzM0VmgwY3dXY2pPRm5QeDNzWmNCQ0lwMFpoRGx0?=
 =?utf-8?B?N2tXZWltbyt6QnhFWDJrSDArWnE4K1QxR0lYUXZrNEFnbSs2eGhYcFE4bEpO?=
 =?utf-8?B?V3hSNDdxQnFCaFR6OTZ5cUhjNFNzK0ZDbnp1d0hta3lpb3c5VDBmQ3E2Y1pr?=
 =?utf-8?B?bmVlOGxVdFNGYmJtcmVtZVRJVGxHUUJ6SnhzSklRQ0xlU0lSbVNEV2xPQnJa?=
 =?utf-8?B?czZXbHpYRHgxMnpxbFM0ejhHb0RvWFhkQXdNWHNaZmlXYVN4eDdITGY0Uzdz?=
 =?utf-8?Q?gTlTq97rwQUGy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VXQURIMm1NTXJlVFJVRUo0dzJVVyszUHRMRHVFUzAxM0o3NEUxUWdkMWQ0?=
 =?utf-8?B?eEtmVVExNGVRT0JQMnpuczdET3ltQXhESC9OY1UzQ2IzaW1hNFd1OXJWSXUr?=
 =?utf-8?B?NHVyQklYTkV6NVoxREVsLzBDcmZuNkRIV3FObTlxRUVoTS9UMGdyMGhjL0lD?=
 =?utf-8?B?cDhqcnZSQWJqMjluVVpSUVVidE1iVFJNdy93cWFRMlNKZ0NEK3NQTkI1WUxh?=
 =?utf-8?B?bTVaOFpTUTVMdDFPUTBqeURRdmpzNHpacHpQdFpDM1ZpcURIWHhqaTZMazRX?=
 =?utf-8?B?ZmMzSzlpVDJUWWFSeFpFL2hYc1dCdEdaV0tVRGlaOWxDL0NGSXVtR0E1Y1NJ?=
 =?utf-8?B?bHpMOE54UlNCNjZpcHpoT25qMnlRWDhXTWJsSndwOFNFM0ZxcmRnNUprRmZY?=
 =?utf-8?B?andjQkxQd2pvN0o2TlNaOHJ1c295WVB3MVJpcFZENGlQdjZqdzlLZnU4ZVdo?=
 =?utf-8?B?YzV4aDJTT0Ivc0YyZ3FBTWl5SGhvNGt1eENISVo0elBRM0FFTTYvcVZBeWtT?=
 =?utf-8?B?QkdKcW8rZjNwMElZK3pWTDcxZ2tjOGkrRThtMGdBRDBRTHlFT0VJUmcwbDh4?=
 =?utf-8?B?L28yZldteHpiRnJPYUdlZ2Qxc2gwTGtxcXdlb0ZHeFBWUERnRGF1R0JBcVJI?=
 =?utf-8?B?WXdSSnVSVnZwZnI0T2U0UzZaRlRGN0pUdG43ZTNuVHlIazNyd1J0NnJpVlFX?=
 =?utf-8?B?Sm9HdTBLS3ExMmYrNWVJMlpSN0thRnJqaWtLZXdicHIvZ0ZqdGZURHd3MVBo?=
 =?utf-8?B?c3lBeVZVSy9nb1UxSXlFTll1UXl4cjNSS01KUkNvaDhoQjhob2dtVmhZNTFX?=
 =?utf-8?B?bUVaN3htVDRidlk5YVBoa2MxMlJCNUprb2RRaUtSdktPa0hHeDBXZFBIUWl1?=
 =?utf-8?B?NUs5YTNHS2lnVlFFR09VVnlSYWlzK1l1ZjVjOEVSckg3MGNUR1dkOEgvcyt2?=
 =?utf-8?B?RmdxV052U0JHaWV2QU9WclR4QmtFdTI4dGZ5cEdOU1JCdjRNaXFLeW1tWFNF?=
 =?utf-8?B?Z21RcFphbnZWZ2J1VG1kd2hwVHNVQmlWR0JTZy9iVFc0b0pHTktvdjRGQnkr?=
 =?utf-8?B?T20zNXhWa0RDYXl5QTVxWnRYQ1NqdjRVU3NhaTNkUVNFTlR6RCtlc1UzdkR3?=
 =?utf-8?B?MklpV1VzeGRqd3VNUzdOVW9LbVFOK2piaDRQbmFkQXVXRitIa0dIZUoyQitR?=
 =?utf-8?B?UGw2MjA5MmVpZFYyZ2hSaElOeFZKR3l4RGRQellsR0Z4ZVd5dUc1UENZeWhR?=
 =?utf-8?B?MWphZmpOYTFZMDNCcG5jbk5XK0twUitTWG93elhjN0syRHZWUjJxVmJjMWJu?=
 =?utf-8?B?RDVZa2k3UHlIc3AvUDEwNlVjMTJCc1VwWGs3Mkg5SktJNThzbmtqSlVCRC9V?=
 =?utf-8?B?SHhyYXRPN001eXVkUlpVNG1zcmp5TWsrdUNEc3piK1ZPa2I0Yy9XYzZSb3BY?=
 =?utf-8?B?c3JuUXgxUGZxd2IzMFQxMmtXcXZ5bWtjVnN5alBmS2VpY1VxeklUMWtrUTJZ?=
 =?utf-8?B?cHFSRHpHZVdFVzJWbWM1WXQ0M29uOXltcVBzcFhrUzZtc0hhckRTeERBcWZQ?=
 =?utf-8?B?TG10TkNvaFR4SklXbC9scGpqbVpaZUlLRzFqL2E1YUdHdU5CYlZXVGFuRWlk?=
 =?utf-8?B?N0lqMEZqeHAxNy9kZzhpSnhuZlBxR1p2NTlhSk9WMFlJNHZrbmQwanVOeFQ0?=
 =?utf-8?B?a1llRStXTHRCazZYa0N4a3U4Q21ZVTRKeU9Td2EyQ2VXZDBBbzZidTFwMG93?=
 =?utf-8?B?Q1dhS1VDb0JPQ1ZtZXY1L1VyaDU3UmxZeGZGN2crenQ4a1Mvb1FPdzhWRWZW?=
 =?utf-8?B?UDFwZmh0N2VZUy9tRzdmamYxaUlvNW1nRjJ3WStub3UyNi9VQ2R1V01VR2tZ?=
 =?utf-8?B?L0ozOUUwVlRCRlhKbHM1ZkJsZlhJb1ZTemhzaWZqTUtveUp0WEVTWU5qbXpR?=
 =?utf-8?B?d0d5SDdyUnNJV2VWZTRqVlZFRjF2YXNraFg3eFZ0cnFLTXJCb25OV2RaYkkr?=
 =?utf-8?B?VHlNQzNBUU1LR29qSjZNWVFFbzRyZXZ4SlJ0cXFCdjR1NnZPUkozN1VyYWVB?=
 =?utf-8?B?NlRUYzBodDJ4OUt6OFk0Q0ljUWtpRStjN0s4aW5LRXJ1N0dzQUU3WkQ3am1t?=
 =?utf-8?Q?Ll/hx7QAv4KMTKJKKrz0bQI4N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2712dff-f9a6-4e11-2203-08dd6c4d8afb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:04:06.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GY+htADWSKaudnyKvCFyVs079FQdml9PwJmnDjcmXxI/wuvnF5UdzBhbf/eoiku6vYbZYSPLKJ2Hv6jk1JYTdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426



On 3/17/2025 7:37 PM, Mark Brown wrote:
> On Fri, Mar 14, 2025 at 12:04:32AM +0530, Raju Rangoju wrote:
> 
>> This patch introduces an IOCTL command to set the configuration of the
>> eSPI controller and eSPI slave0. The configuration options include
>> parameters like frequency, channel, and IO mode. The new IOCTL command
>> allow users to dynamically configure the eSPI controller and slave.
> 
> Why?  We have spidev...

There is no support from the slave device side to register as an SPI 
slave device with the SPI framework and provide SPI communication.

For this reason, the AMD eSPI driver can only handle device 
initialization itself and provide a character device file as an 
interface to user space.

